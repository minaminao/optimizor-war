// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IChallenge} from "src/IChallenge.sol";

// Title: Compare
// Input: x, a, y, b
//  - x, y: uint256 in [2, 10]
//  - a, b: uint256 in [1, maxE[x]], [1, maxE[y]]
//  - maxE[x]: max value of the exponent of x that does not overflow uint256 (e.g. maxE[2] = 255, maxE[3] = 161)
// Output: x^a >= y^b

contract CompareChallenge is IChallenge {
    uint256 constant TEST_CASES = 25;
    string public name = "Compare";

    function run(address solverAddr, uint256 seed) external returns (uint48 gasUsed) {
        uint256 random = seed;
        uint256[11] memory maxE = [uint256(0), 0, 255, 161, 127, 110, 99, 91, 85, 80, 77];

        for (uint256 testCase = 0; testCase < TEST_CASES; testCase++) {
            uint256 x = 2 + (random % 9);
            random = uint256(keccak256(abi.encode(random)));
            uint256 y = 2 + (random % 9);
            random = uint256(keccak256(abi.encode(random)));
            uint256 a = 1 + (random % maxE[x]);
            random = uint256(keccak256(abi.encode(random)));
            uint256 b = 1 + (random % maxE[y]);

            uint256 gasBefore = gasleft();
            (bool success, bytes memory output) = address(solverAddr).call(abi.encode(x, a, y, b));
            uint256 gasAfter = gasleft();
            require(success);

            gasUsed += uint48(gasBefore - gasAfter);

            bool playerAnswer = abi.decode(output, (bool));
            bool expectedAnswer = getExpectedAnswer(x, a, y, b);
            if (playerAnswer != expectedAnswer) {
                revert WrongAnswer();
            }

            random = uint256(keccak256(abi.encode(random)));
        }

        gasUsed /= uint48(TEST_CASES);
    }

    function getExpectedAnswer(uint256 x, uint256 a, uint256 y, uint256 b) private pure returns (bool) {
        // this is not optimized
        return _pow(x, a) >= _pow(y, b);
    }

    function _pow(uint256 x, uint256 a) private pure returns (uint256 res) {
        res = 1;
        while (true) {
            if (a % 2 == 1) {
                res *= x;
            }
            a /= 2;
            if (a == 0) {
                break;
            }
            x *= x;
        }
    }
}
