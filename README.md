![](assets/logo.svg)

A gas golf game where you create gas-efficient contracts for 6 challenges. 
This game is inspired by [Optimizor Club](https://github.com/OptimizorClub).

## Overview 

This game is part of [Huffathon](https://huff.sh/hackathon) and will run for **10 hours, starting at 22:00 UTC on September 28, 2023.**

Once the game starts, players who have created the most gas-efficient contract for each challenge will be listed on the challenge hex at https://minaminao.github.io/optimizor-war/.

There are two types of prizes in this game:

1. At the end of the game, the player whose name appears on the most hexes wins **$200**.
2. The player whose name is on the hexes for the longest total time wins **$200**.

It's up to you which one you want to go for.

## Registry

[The `OptimizorWar` contract](src/OptimizorWar.sol) is the registry for challenges.
Challenges can be registered by executing the `addChallenge(uint256 challengeId, address challengeAddr)` function.
This function is modified by `onlyOwner`, so only the admin can execute it.

After the game start time has passed, the admin will deploy 6 challenges on Optimism.
Once the challenges are registered, links to the OP Mainnet Explorer for the contract addresses will be listed on each hex of the UI.
You can check the source code of the challenges by jumping to that page.
After that, they will also be published in this repository.

## How to Solve Challenges

To solve challenges, players need to execute the two functions:

1. Call the `commit(bytes32 key)`
2. After waiting for 32 blocks, call the `challenge(uint256 challengeId, address solverAddr, uint256 salt, string calldata solverHandle)`  function

The key is `keccak256(abi.encode(msg.sender, address(solver).codehash, salt))`.
Please set the salt to a random value.
The reason for waiting 32 blocks is to prevent front-running.

Also, your contract must be pure.
Being pure means not executing opcodes that mutate the state or call other contracts.

When you execute the `challenge` function, the gas cost will be measured on-chain.
If the gas cost consumed is less than that of the most gas-efficient solver recorded in the `OptimizorWar` contract, the solver will be recorded.

As an example, a simple challenge has been deployed to `challengeId = 42`.
By using [optimizor-war-solver-template](https://github.com/minaminao/optimizor-war-solver-template), you can quickly check whether the challenge has been solved locally and also submit the solver on-chain.
It would be good to reuse this for other challenges.

## Deployment Addresses

| Contract Name     | Challenge Id | Address                                                                                                                          |
| ----------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| OptimizorWar      | -            | [0x7ef472638fCf72216466D20C92265F9eEac5C716](https://optimistic.etherscan.io/address/0x7ef472638fCf72216466D20C92265F9eEac5C716) |
| Example Challenge | 42           | [0xE55E00d743751FD622a9a0478b3C4a47EF3CD632](https://optimistic.etherscan.io/address/0xe55e00d743751fd622a9a0478b3c4a47ef3cd632) |
| (Challenge 0)     | 0            | TBA                                                                                                                              |
| (Challenge 1)     | 1            | TBA                                                                                                                              |
| (Challenge 2)     | 2            | TBA                                                                                                                              |
| (Challenge 3)     | 3            | TBA                                                                                                                              |
| (Challenge 4)     | 4            | TBA                                                                                                                              |
| (Challenge 5)     | 5            | TBA                                                                                                                              |
