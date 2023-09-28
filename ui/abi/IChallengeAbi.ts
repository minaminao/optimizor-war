export const IChallengeAbi = [
    {
        "inputs": [],
        "name": "WrongAnswer",
        "type": "error"
    },
    {
        "inputs": [],
        "name": "name",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "solverAddr",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "seed",
                "type": "uint256"
            }
        ],
        "name": "run",
        "outputs": [
            {
                "internalType": "uint48",
                "name": "gasUsed",
                "type": "uint48"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    }
]
