// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {LibSort} from "solady/src/utils/LibSort.sol";
import {IChallenge} from "src/IChallenge.sol";

// Title: Mode
// Input: arr
//  - arr: a random array of uint256 values in [0, 1]
//  - arr.length in [5, 10)
// Output: mode
//  - mode: the lowest value that appears the most in arr

contract ModeChallenge is IChallenge {
    using LibSort for uint256[];

    uint256 constant TEST_CASES = 25;
    string public name = "Mode";

    function run(address solverAddr, uint256 seed) external returns (uint48 gasUsed) {
        uint256 random = seed;

        for (uint256 testCase = 0; testCase < TEST_CASES; testCase++) {
            uint256 arrLength = 5 + testCase / 5;
            uint256[] memory arr = new uint256[](arrLength);

            for (uint256 i = 0; i < arrLength; i++) {
                arr[i] = random % 2;
                random = uint256(keccak256(abi.encode(random)));
            }

            uint256 gasBefore = gasleft();
            (bool success, bytes memory output) = address(solverAddr).call(abi.encode(arr));
            uint256 gasAfter = gasleft();
            require(success);

            gasUsed += uint48(gasBefore - gasAfter);

            uint256 playerAnswer = abi.decode(output, (uint256));
            uint256 expectedAnswer = getExpectedAnswer(arr);
            if (playerAnswer != expectedAnswer) {
                revert WrongAnswer();
            }

            random = uint256(keccak256(abi.encode(random)));
        }

        gasUsed /= uint48(TEST_CASES);
    }

    function getExpectedAnswer(uint256[] memory arr) private pure returns (uint256 mode) {
        // this is not optimized
        arr.sort();
        uint256 maxCount = 1;
        uint256 count = 1;
        mode = arr[0];
        for (uint256 i = 1; i < arr.length; i++) {
            if (arr[i] == arr[i - 1]) {
                count++;
            } else {
                if (count > maxCount) {
                    maxCount = count;
                    mode = arr[i - 1];
                }
                count = 1;
            }
        }
        if (count > maxCount) {
            mode = arr[arr.length - 1];
        }
    }
}
