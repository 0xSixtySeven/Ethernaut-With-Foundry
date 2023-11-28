// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Objectives
// This is a coin flipping game where you need to build up your winning streak by guessing the outcome of a coin flip. To complete this level you'll need to use your psychic abilities to guess the correct outcome 10 times in a row.

contract CoinFlip {
    // STATE VARIABLES
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0; // It will always initialize the contract with 0 consecutiveWins
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1)); // blockhash() returns the hash of the given block - here the previous block. Its calling a global variable block.number which is the current block number. So block.number - 1 is the previous block number. Which is vulnerable to block.timestamp manipulation.

        if (lastHash == blockValue) {
            // If the lastHash is equal to the current blockhash, it will revert the transaction. This is to prevent the same blockhash being used twice.
            revert();
        }

        lastHash = blockValue; // Set the lastHash to the current blockhash
        uint256 coinFlip = blockValue / FACTOR; // This is the vulnerable part. The blockValue is divided by FACTOR which is a constant.
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}
