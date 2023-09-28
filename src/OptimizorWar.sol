// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "solady/src/auth/Ownable.sol";
import {IChallenge} from "src/IChallenge.sol";
import {Puretea} from "puretea/Puretea.sol";

contract OptimizorWar is Ownable {
    struct Submission {
        address senderAddr;
        uint96 blockNumber;
    }

    struct ChallengeInfo {
        address challengeAddr;
        uint96 solutionCount;
    }

    struct OptimizorUpdate {
        address addr;
        uint48 gasUsed;
        uint48 timestamp;
        string handle;
    }

    uint256 constant MAX_HANDLE_LENGTH = 16;
    uint256 public constant BLOCKS_TO_PREVENT_FRONT_RUNNING = 32;
    mapping(uint256 => ChallengeInfo) public challenges;
    mapping(bytes32 => Submission) public submissions;
    mapping(uint256 => OptimizorUpdate[]) public optimizorUpdates;

    event Solved(
        uint256 indexed challengeId, address indexed solverAddr, uint256 gasUsed, string solverHandle, bool isOptimizor
    );

    error ChallengeAlreadyExists();

    error TooEarlyToChallenge();
    error CodeNotSubmitted();
    error ChallengeNotExists();
    error HandleTooLong();
    error NotPure();

    constructor() {
        _initializeOwner(msg.sender);
    }

    function addChallenge(uint256 challengeId, address challengeAddr) external onlyOwner {
        if (challenges[challengeId].challengeAddr != address(0)) {
            revert ChallengeAlreadyExists();
        }
        challenges[challengeId] = ChallengeInfo({challengeAddr: challengeAddr, solutionCount: 0});
        optimizorUpdates[challengeId].push(
            OptimizorUpdate({
                addr: address(0),
                gasUsed: type(uint48).max,
                timestamp: uint48(block.timestamp),
                handle: ""
            })
        );
    }

    // key: keccak256(abi.encode(msg.sender, codehash, salt));
    function commit(bytes32 key) external {
        submissions[key] = Submission(msg.sender, uint96(block.number));
    }

    function challenge(uint256 challengeId, address solverAddr, uint256 salt, string calldata solverHandle) external {
        ChallengeInfo storage challengeInfo = challenges[challengeId];
        bytes32 key = keccak256(abi.encode(msg.sender, solverAddr.codehash, salt));

        if (submissions[key].blockNumber + BLOCKS_TO_PREVENT_FRONT_RUNNING > block.number) {
            revert TooEarlyToChallenge();
        }

        if (submissions[key].senderAddr == address(0)) {
            revert CodeNotSubmitted();
        }

        if (challengeInfo.challengeAddr == address(0)) {
            revert ChallengeNotExists();
        }

        if (bytes(solverHandle).length > MAX_HANDLE_LENGTH) {
            revert HandleTooLong();
        }

        if (!Puretea.isPureGlobal(solverAddr.code)) {
            revert NotPure();
        }

        uint256 seed = uint256(keccak256(abi.encode(block.prevrandao, challengeInfo.solutionCount)));
        uint48 gasUsed = IChallenge(challengeInfo.challengeAddr).run(solverAddr, seed);
        challengeInfo.solutionCount++;
        bool isOptimizor = gasUsed < getOptimizor(challengeId).gasUsed;

        emit Solved(challengeId, solverAddr, gasUsed, solverHandle, isOptimizor);

        if (isOptimizor) {
            optimizorUpdates[challengeId].push(
                OptimizorUpdate({
                    addr: solverAddr,
                    gasUsed: gasUsed,
                    timestamp: uint48(block.timestamp),
                    handle: solverHandle
                })
            );
        }
    }

    function getOptimizor(uint256 challengeId) public view returns (OptimizorUpdate memory) {
        return optimizorUpdates[challengeId][optimizorUpdates[challengeId].length - 1];
    }

    function getOptimizorUpdates(uint256 challengeId) external view returns (OptimizorUpdate[] memory) {
        return optimizorUpdates[challengeId];
    }
}
