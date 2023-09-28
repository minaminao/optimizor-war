// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IChallenge} from "src/IChallenge.sol";

// Title: Reverse
// Input: byteStr
//  - byteStr: a random byte string of 64 bytes
// Output: reversedArr
//  - reversedArr: reversed byteStr

contract ReverseChallenge is IChallenge {
    uint256 constant TEST_CASES = 10;
    uint256 constant L = 2;
    string public name = "Reverse";

    function run(address solverAddr, uint256 seed) external returns (uint48 gasUsed) {
        uint256 random = seed;

        for (uint256 testCase = 0; testCase < TEST_CASES; testCase++) {
            bytes memory byteStr;
            for (uint256 i = 0; i < L; i++) {
                byteStr = bytes.concat(byteStr, abi.encode(random));
                random = uint256(keccak256(abi.encode(random)));
            }

            uint256 gasBefore = gasleft();
            (bool success, bytes memory output) = address(solverAddr).call(abi.encode(byteStr));
            uint256 gasAfter = gasleft();
            require(success);

            gasUsed += uint48(gasBefore - gasAfter);

            bytes memory playerAnswer = abi.decode(output, (bytes));
            bytes memory expectedAnswer = getExpectedAnswer(byteStr);
            if (keccak256(playerAnswer) != keccak256(expectedAnswer)) {
                revert WrongAnswer();
            }

            random = uint256(keccak256(abi.encode(random)));
        }

        gasUsed /= uint48(TEST_CASES);
    }

    function getExpectedAnswer(bytes memory byteStr) private pure returns (bytes memory reversedArr) {
        // this is not optimized
        reversedArr = new bytes(byteStr.length);
        for (uint256 i = 0; i < byteStr.length; i++) {
            reversedArr[i] = byteStr[byteStr.length - 1 - i];
        }
    }
}
