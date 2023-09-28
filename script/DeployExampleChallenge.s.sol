// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {OptimizorWar} from "src/OptimizorWar.sol";
import {ExampleChallenge} from "src/challenges/ExampleChallenge.sol";

contract DeployExampleChallengeScript is Script {
    // anvil:
    // forge script DeployExampleChallengeScript --rpc-url $FOUNDRY_ETH_RPC_URL --broadcast --private-key $PRIVATE_KEY
    // address constant OPTIMIZOR_WAR_ADDR = 0xc351628EB244ec633d5f21fBD6621e1a683B1181;

    // optimism:
    // forge script DeployExampleChallengeScript --rpc-url $FOUNDRY_ETH_RPC_URL --verify --broadcast --sender 0x878bb995c26ab3c085af006ba2f311c107cac7ad
    address constant OPTIMIZOR_WAR_ADDR = 0x7ef472638fCf72216466D20C92265F9eEac5C716;

    function run() public {
        OptimizorWar optimizorWar = OptimizorWar(OPTIMIZOR_WAR_ADDR);
        require(address(optimizorWar).code.length != 0);

        vm.startBroadcast();

        ExampleChallenge exampleChallenge = new ExampleChallenge();
        optimizorWar.addChallenge(42, address(exampleChallenge));

        vm.stopBroadcast();
    }
}
