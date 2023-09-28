// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ExampleSolver {
    fallback(bytes calldata /* input */ ) external returns (bytes memory output) {
        return abi.encode(uint256(42));
    }
}
