// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {FixedPointMathLib} from "solady/src/utils/FixedPointMathLib.sol";
import {IChallenge} from "src/IChallenge.sol";

// Title: Divisors
// Input: x
//  - x: uint256 in [1, 1000]
// Output: count
//  - count: number of divisors of x

contract DivisorsChallenge is IChallenge {
    using FixedPointMathLib for uint256;

    uint256 constant TEST_CASES = 25;
    string public name = "Divisors";

    function run(address solverAddr, uint256 seed) external returns (uint48 gasUsed) {
        uint256 random = seed;

        for (uint256 testCase = 0; testCase < TEST_CASES; testCase++) {
            uint256 x = 1 + (random % 1000);

            uint256 gasBefore = gasleft();
            (bool success, bytes memory output) = address(solverAddr).call(abi.encode(x));
            uint256 gasAfter = gasleft();
            require(success);

            gasUsed += uint48(gasBefore - gasAfter);

            uint256 playerAnswer = abi.decode(output, (uint256));
            uint256 expectedAnswer = getExpectedAnswer(x);
            if (playerAnswer != expectedAnswer) {
                revert WrongAnswer();
            }

            random = uint256(keccak256(abi.encode(random)));
        }

        gasUsed /= uint48(TEST_CASES);
    }

    function getExpectedAnswer(uint256 x) public pure returns (uint256 count) {
        // this is not optimized
        uint256 sqrtX = x.sqrt();
        if (sqrtX * sqrtX == x) {
            count++;
            sqrtX--;
        }
        for (uint256 i = 1; i <= sqrtX; i++) {
            if (x % i == 0) {
                count += 2;
            }
        }
    }
}
