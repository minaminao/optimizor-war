// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IChallenge {
    error WrongAnswer();

    function name() external view returns (string memory);
    function run(address solverAddr, uint256 seed) external returns (uint48 gasUsed);
}
