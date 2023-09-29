// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {LibSort} from "solady/src/utils/LibSort.sol";
import {LibPRNG} from "solady/src/utils/LibPRNG.sol";
import {IChallenge} from "src/IChallenge.sol";

// Title: Sort5
// Input: arr
//  - arr: a random array of uint256 values
//  - arr.length == 5
//  - arr contains no duplicate values
// Output: sortedArr
//  - sortedArr: arr sorted in ascending order

contract Sort5Challenge is IChallenge {
    using LibSort for uint256[];
    using LibPRNG for LibPRNG.PRNG;

    uint256 constant N = 5;
    uint256 constant TEST_CASES = 5 * 4 * 3 * 2 * 1;
    string public name = "Sort5";

    function run(address solverAddr, uint256 seed) external returns (uint48 gasUsed) {
        LibPRNG.PRNG memory prng;
        prng.seed(seed);

        uint256[] memory idx = new uint256[](N);
        for (uint256 i = 0; i < N; i++) {
            idx[i] = i;
        }
        uint256[] memory v = new uint256[](N);
        v[0] = prng.next() % 10;
        for (uint256 i = 1; i < N; i++) {
            v[i] = v[i - 1] + 1 + prng.next() % 10;
        }
        prng.shuffle(v);
        uint256[] memory arr = new uint256[](N);

        for (uint256 testCase = 0; testCase < TEST_CASES; testCase++) {
            for (uint256 i = 0; i < N; i++) {
                arr[i] = v[idx[i]];
            }

            uint256 gasBefore = gasleft();
            (bool success, bytes memory output) = address(solverAddr).call(abi.encode(arr));
            uint256 gasAfter = gasleft();
            require(success);

            gasUsed += uint48(gasBefore - gasAfter);

            uint256[] memory playerAnswer = abi.decode(output, (uint256[]));
            uint256[] memory expectedAnswer = getExpectedAnswer(arr);
            if (keccak256(abi.encode(playerAnswer)) != keccak256(abi.encode(expectedAnswer))) {
                revert WrongAnswer();
            }

            if (testCase < TEST_CASES - 1) {
                idx = _getNextPermutation(idx);
            }
        }

        gasUsed /= uint48(TEST_CASES);
    }

    function getExpectedAnswer(uint256[] memory arr) private pure returns (uint256[] memory) {
        // this is not optimized
        for (uint256 i = 0; i < N; i++) {
            for (uint256 j = i + 1; j < N; j++) {
                if (arr[i] > arr[j]) {
                    uint256 tmp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = tmp;
                }
            }
        }
        return arr;
    }

    function _getNextPermutation(uint256[] memory arr) private pure returns (uint256[] memory) {
        uint256 r = arr.length;
        for (uint256 i = r - 2; i >= 0; i--) {
            if (arr[i] < arr[i + 1]) {
                for (uint256 j = r - 1; j > i; j--) {
                    if (arr[j] > arr[i]) {
                        uint256 tmp = arr[i];
                        arr[i] = arr[j];
                        arr[j] = tmp;
                        uint256 p = i + 1;
                        uint256 q = r - 1;
                        while (p < q) {
                            tmp = arr[p];
                            arr[p] = arr[q];
                            arr[q] = tmp;
                            p++;
                            q--;
                        }
                        return arr;
                    }
                }
            }
        }
        revert("no next permutation");
    }
}
