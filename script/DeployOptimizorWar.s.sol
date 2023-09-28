// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {OptimizorWar} from "src/OptimizorWar.sol";

contract DeployOptimizorWarScript is Script {
    // anvil:
    // export FOUNDRY_ETH_RPC_URL=http://localhost:8545
    // export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 # anvil default account
    // forge script DeployOptimizorWarScript --rpc-url $FOUNDRY_ETH_RPC_URL --broadcast --private-key $PRIVATE_KEY

    // optimism:
    // export FOUNDRY_ETH_RPC_URL=
    // export ETHERSCAN_API_KEY=
    // export ETH_KEYSTORE=
    // export VERIFIER_URL=https://api-optimistic.etherscan.io/api
    // forge script DeployOptimizorWarScript --rpc-url $FOUNDRY_ETH_RPC_URL --verify --broadcast --sender 0x878bb995c26ab3c085af006ba2f311c107cac7ad

    // optimism-goerli:
    // export FOUNDRY_ETH_RPC_URL=
    // export ETHERSCAN_API_KEY=
    // export ETH_KEYSTORE=
    // export VERIFIER_URL=https://api-goerli-optimistic.etherscan.io/api
    // forge script DeployOptimizorWarScript --rpc-url $FOUNDRY_ETH_RPC_URL --verify --broadcast --sender 0x878bb995c26ab3c085af006ba2f311c107cac7ad
    function run() public {
        vm.startBroadcast();

        new OptimizorWar();

        vm.stopBroadcast();
    }
}
