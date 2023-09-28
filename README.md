![](assets/logo.svg)

A gas golf game where you create gas-efficient contracts for 6 challenges. Inspired by [Optimizor Club](https://github.com/OptimizorClub).

## Overview 

This game is part of [Huffathon](https://huff.sh/hackathon) and will run for **10 hours, starting at 22:00 UTC on September 28, 2023.**

Once the game begins, players who have made the most gas-efficient contracts for each challenge will be featured on the challenge hex at https://minaminao.github.io/optimizor-war/.

There are two types of prizes in this game:

1. The player whose name appears on the most hexes at the end wins **$250**.
2. The player whose name is on the hexes for the longest total time wins **$250**.

It's up to you which one you want to go for.

## Registry

[The `OptimizorWar` contract](src/OptimizorWar.sol) is the challenge registry.
Challenges can be registered by calling the `addChallenge(uint256 challengeId, address challengeAddr)` function.
Only the admin can use this function because it is modified by `onlyOwner`.

After the game starts, the admin will deploy 6 challenges on Optimism.
Once the challenges are registered, you'll see links to the OP Mainnet Explorer for the contract addresses on each hex of the UI.
To check the source code of the challenges, go to that page by clicking the links.
After that, they will also be published in this repository.

## Solving Challenges

To solve challenges, players need to do two things:

1. Call the `commit(bytes32 key)` function.
2. After waiting for 32 blocks, call the `challenge(uint256 challengeId, address solverAddr, uint256 salt, string calldata solverHandle)`  function.

The key is `keccak256(abi.encode(msg.sender, address(solver).codehash, salt))`.
Please use a random value for the salt and wait 32 blocks before calling the `challenge` function to prevent front-running.

Also, your contract should be pure.
This means it should not execute opcodes that mutate the state or call other contracts.
For more information, see [axic/puretea](https://github.com/axic/puretea).

When you execute the `challenge` function, the gas cost will be measured on-chain.
If your gas cost is lower than that of the most gas-efficient solver, the solver will be recorded in the `OptimizorWar` contract.

For practice, a simple challenge has been set up as `challengeId = 42`.
Using [optimizor-war-example-solver](https://github.com/minaminao/optimizor-war-example-solver), you can quickly see if the challenge is solved locally and also submit the solver on-chain.
Feel free to use this for other challenges, too!

## Deployment Addresses

| Contract Name     | Challenge Id | Address                                                                                                                          |
| ----------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| OptimizorWar      | -            | [0x7ef472638fCf72216466D20C92265F9eEac5C716](https://optimistic.etherscan.io/address/0x7ef472638fCf72216466D20C92265F9eEac5C716) |
| Example Challenge | 42           | [0xE55E00d743751FD622a9a0478b3C4a47EF3CD632](https://optimistic.etherscan.io/address/0xe55e00d743751fd622a9a0478b3c4a47ef3cd632) |
| (Challenge 0)     | 0            | TBA                                                                                                                              |
| (Challenge 1)     | 1            | TBA                                                                                                                              |
| (Challenge 2)     | 2            | TBA                                                                                                                              |
| (Challenge 3)     | 3            | TBA                                                                                                                              |
| Reverse           | 4            | [0xd6Ca10E9a443f83Db6Aa527a423b7150a1Cfc4f5](https://optimistic.etherscan.io/address/0xd6Ca10E9a443f83Db6Aa527a423b7150a1Cfc4f5) |
| (Challenge 5)     | 5            | TBA                                                                                                                              |
