export const OptimizorWarAbi = [
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [],
        "name": "ChallengeAlreadyExists",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "ChallengeNotExists",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "CodeNotSubmitted",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "HandleTooLong",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "NewOwnerIsZeroAddress",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "NoHandoverRequest",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "NotPure",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "TooEarlyToChallenge",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "Unauthorized",
        "type": "error"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "pendingOwner",
                "type": "address"
            }
        ],
        "name": "OwnershipHandoverCanceled",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "pendingOwner",
                "type": "address"
            }
        ],
        "name": "OwnershipHandoverRequested",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "oldOwner",
                "type": "address"
            },
            {
                "indexed": true,
                "internalType": "address",
                "name": "newOwner",
                "type": "address"
            }
        ],
        "name": "OwnershipTransferred",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "uint256",
                "name": "challengeId",
                "type": "uint256"
            },
            {
                "indexed": true,
                "internalType": "address",
                "name": "solverAddr",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "gasUsed",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "string",
                "name": "solverHandle",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "bool",
                "name": "isOptimizor",
                "type": "bool"
            }
        ],
        "name": "Solved",
        "type": "event"
    },
    {
        "inputs": [],
        "name": "BLOCKS_TO_PREVENT_FRONT_RUNNING",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "challengeId",
                "type": "uint256"
            },
            {
                "internalType": "address",
                "name": "challengeAddr",
                "type": "address"
            }
        ],
        "name": "addChallenge",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "cancelOwnershipHandover",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "challengeId",
                "type": "uint256"
            },
            {
                "internalType": "address",
                "name": "solverAddr",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "salt",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "solverHandle",
                "type": "string"
            }
        ],
        "name": "challenge",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "challenges",
        "outputs": [
            {
                "internalType": "address",
                "name": "challengeAddr",
                "type": "address"
            },
            {
                "internalType": "uint96",
                "name": "solutionCount",
                "type": "uint96"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "bytes32",
                "name": "key",
                "type": "bytes32"
            }
        ],
        "name": "commit",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "pendingOwner",
                "type": "address"
            }
        ],
        "name": "completeOwnershipHandover",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "challengeId",
                "type": "uint256"
            }
        ],
        "name": "getOptimizor",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "address",
                        "name": "addr",
                        "type": "address"
                    },
                    {
                        "internalType": "uint48",
                        "name": "gasUsed",
                        "type": "uint48"
                    },
                    {
                        "internalType": "uint48",
                        "name": "timestamp",
                        "type": "uint48"
                    },
                    {
                        "internalType": "string",
                        "name": "handle",
                        "type": "string"
                    }
                ],
                "internalType": "struct OptimizorWar.OptimizorUpdate",
                "name": "",
                "type": "tuple"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "challengeId",
                "type": "uint256"
            }
        ],
        "name": "getOptimizorUpdates",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "address",
                        "name": "addr",
                        "type": "address"
                    },
                    {
                        "internalType": "uint48",
                        "name": "gasUsed",
                        "type": "uint48"
                    },
                    {
                        "internalType": "uint48",
                        "name": "timestamp",
                        "type": "uint48"
                    },
                    {
                        "internalType": "string",
                        "name": "handle",
                        "type": "string"
                    }
                ],
                "internalType": "struct OptimizorWar.OptimizorUpdate[]",
                "name": "",
                "type": "tuple[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "optimizorUpdates",
        "outputs": [
            {
                "internalType": "address",
                "name": "addr",
                "type": "address"
            },
            {
                "internalType": "uint48",
                "name": "gasUsed",
                "type": "uint48"
            },
            {
                "internalType": "uint48",
                "name": "timestamp",
                "type": "uint48"
            },
            {
                "internalType": "string",
                "name": "handle",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "internalType": "address",
                "name": "result",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "pendingOwner",
                "type": "address"
            }
        ],
        "name": "ownershipHandoverExpiresAt",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "result",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "renounceOwnership",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "requestOwnershipHandover",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "bytes32",
                "name": "",
                "type": "bytes32"
            }
        ],
        "name": "submissions",
        "outputs": [
            {
                "internalType": "address",
                "name": "senderAddr",
                "type": "address"
            },
            {
                "internalType": "uint96",
                "name": "blockNumber",
                "type": "uint96"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "newOwner",
                "type": "address"
            }
        ],
        "name": "transferOwnership",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    }
]
