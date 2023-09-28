// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IChallenge} from "src/IChallenge.sol";

contract ExampleChallenge is IChallenge {
    uint256 constant TEST_CASES = 50;
    string public name = "Example";

    function run(address solverAddr, uint256 /* seed */ ) external returns (uint48 gasUsed) {
        for (uint256 testCase = 0; testCase < TEST_CASES; testCase++) {
            uint256 gasBefore = gasleft();
            (bool success, bytes memory output) = address(solverAddr).call("");
            uint256 gasAfter = gasleft();
            require(success);

            gasUsed += uint48(gasBefore - gasAfter);

            uint256 playerAnswer = abi.decode(output, (uint256));
            uint256 expectedAnswer = getExpectedAnswer();
            if (playerAnswer != expectedAnswer) {
                revert WrongAnswer();
            }
        }

        gasUsed /= uint48(TEST_CASES);
    }

    function getExpectedAnswer() private pure returns (uint256) {
        return 42;
    }
}
