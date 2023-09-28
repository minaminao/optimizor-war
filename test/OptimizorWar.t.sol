// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {OptimizorWar} from "src/OptimizorWar.sol";
import {ExampleChallenge} from "src/challenges/ExampleChallenge.sol";

contract OptimizorWarExampleTest is Test {
    OptimizorWar optimizorWar;
    ExampleChallenge exampleChallenge;
    uint256 constant CHALLENGE_ID = 42;

    function test() public {
        vm.prevrandao(keccak256(abi.encode("prevrandao")));
        optimizorWar = new OptimizorWar();
        exampleChallenge = new ExampleChallenge();
        optimizorWar.addChallenge(CHALLENGE_ID, address(exampleChallenge));
    }
}
