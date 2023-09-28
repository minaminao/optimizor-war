export FOUNDRY_ETH_RPC_URL=http://localhost:8545
export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 # anvil default account
forge script DeployOptimizorWarScript --rpc-url $FOUNDRY_ETH_RPC_URL --broadcast --private-key $PRIVATE_KEY
forge script DeployChallengesScript --rpc-url $FOUNDRY_ETH_RPC_URL --broadcast --private-key $PRIVATE_KEY
