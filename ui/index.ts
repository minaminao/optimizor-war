import { createPublicClient, createTestClient, http, publicActions, getContract, parseAbiItem } from 'viem';
// https://github.com/wagmi-dev/viem/blob/main/src/chains/definitions/optimism.ts
import { foundry, optimism, optimismGoerli } from 'viem/chains';
import { OptimizorWarAbi } from './abi/OptimizorWarAbi';
import { IChallengeAbi } from './abi/IChallengeAbi';

type Address = `0x${string}`
type OptimizorUpdate = {
  addr: Address,
  gasUsed: number,
  timestamp: number,
  handle: string,
}

const CHALLENGE_IDS = [0, 1, 2, 3, 4, 5, 42];
const END_TIME = 1695974400; // 2023-09-29 08:00:00 UTC

const CHAIN_NAME = import.meta.env.VITE_CHAIN_NAME || "optimism"
const { client, OPTIMIZOR_WAR_ADDR, EXPLORER_BASE_URL } = {
  "optimism": {
    client: createPublicClient({
      chain: optimism,
      transport: http(),
    }),
    OPTIMIZOR_WAR_ADDR: "0x7ef472638fCf72216466D20C92265F9eEac5C716",
    EXPLORER_BASE_URL: "https://optimistic.etherscan.io/"
  },
  "optimism-goerli": {
    client: createPublicClient({
      chain: optimismGoerli,
      transport: http(),
    }),
    OPTIMIZOR_WAR_ADDR: "0x715Ff443571Af51A1F2931Fdb7f6B66b70aae6d0",
    EXPLORER_BASE_URL: "https://goerli-optimism.etherscan.io/"
  },
  "anvil": {
    client: createTestClient({
      chain: foundry,
      mode: 'anvil',
      transport: http(),
    }).extend(publicActions),
    OPTIMIZOR_WAR_ADDR: "0xc351628EB244ec633d5f21fBD6621e1a683B1181",
    EXPLORER_BASE_URL: "https://optimistic.etherscan.io/"
  }
}[CHAIN_NAME]
const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000"

const optimizorWar = getContract({
  address: OPTIMIZOR_WAR_ADDR,
  abi: OptimizorWarAbi,
  publicClient: client,
})

const challengeInfo = {}
const scoreTable: { [challengeId: number]: { [handle: string]: number }, total: [string, number][] } = { total: [] }
const totalScore: { [handle: string]: number } = {}

for (let challengeId of CHALLENGE_IDS) {
  const [challengeAddr, solutionCount] = await optimizorWar.read.challenges([challengeId]) as [Address, number]
  const challengeDeployed = challengeAddr != ZERO_ADDRESS;
  const challenge = getContract({
    address: challengeAddr,
    abi: IChallengeAbi,
    publicClient: client,
  })
  const name = challengeDeployed ? await challenge.read.name() : "???"
  const optimizor = challengeDeployed ? await optimizorWar.read.getOptimizor([challengeId]) as OptimizorUpdate : { addr: ZERO_ADDRESS, gasUsed: "-", handle: "-" }
  challengeInfo[challengeId] = {
    challengeTitle: name,
    challengeAddr,
    optimizorAddr: solutionCount ? optimizor.addr : ZERO_ADDRESS,
    optimizorGasUsed: solutionCount ? optimizor.gasUsed : "-",
    optimizorHandle: solutionCount ? optimizor.handle : "-",
    solutionCount
  }

  if (challengeId >= 6) continue;

  const optimizorUpdates = await optimizorWar.read.getOptimizorUpdates([challengeId]) as OptimizorUpdate[]

  const score = {}
  for (let i = 2; i < optimizorUpdates.length; i++) {
    const prevUpdate = optimizorUpdates[i - 1]
    const update = optimizorUpdates[i]
    const scoreDiff = update.timestamp > END_TIME ? Math.max(0, END_TIME - prevUpdate.timestamp) : update.timestamp - prevUpdate.timestamp
    score[prevUpdate.handle] = (score[prevUpdate.handle] || 0) + scoreDiff
    totalScore[prevUpdate.handle] = (totalScore[prevUpdate.handle] || 0) + scoreDiff
  }
  if (solutionCount) {
    const currentOrEndTime = Math.min(Math.floor(Date.now() / 1000), END_TIME)
    const scoreDiff = Math.max(0, currentOrEndTime - optimizorUpdates[optimizorUpdates.length - 1].timestamp)
    score[optimizor.handle] = (score[optimizor.handle] || 0) + scoreDiff
    totalScore[optimizor.handle] = (totalScore[optimizor.handle] || 0) + scoreDiff
  }
  scoreTable[challengeId] = score
}

scoreTable.total = Object.entries(totalScore).sort((a, b) => b[1] - a[1])

const blockNumber = await client.getBlockNumber()
const logs = await client.getLogs({
  address: OPTIMIZOR_WAR_ADDR,
  event: parseAbiItem("event Solved(uint256 indexed challengeId, address indexed solverAddr, uint256 gasUsed, string solverHandle, bool isOptimizor)"),
  fromBlock: blockNumber - 1000n
})
const latestSolutions: { handle: string, challengeId: bigint, gasUsed: bigint, isOptimizor: boolean, blockNumber: bigint, transactionHash: string }[] = []
for (let i = 0; i < Math.min(logs.length, 20); i++) {
  const log = logs[logs.length - i - 1]
  if (typeof log.args.solverHandle !== "string" || typeof log.args.challengeId !== "bigint" || typeof log.args.gasUsed !== "bigint" || typeof log.args.isOptimizor !== "boolean") {
    continue;
  }
  latestSolutions.push({
    handle: log.args.solverHandle,
    challengeId: log.args.challengeId,
    gasUsed: log.args.gasUsed,
    isOptimizor: log.args.isOptimizor,
    blockNumber: log.blockNumber,
    transactionHash: log.transactionHash
  })
}

export { EXPLORER_BASE_URL, challengeInfo, scoreTable, latestSolutions }
