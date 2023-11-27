// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Objectives
// 1. Claim ownership of this contract
// 2. Drain it's ETH

/**
 * @title Trying to hack the Fallback contract
 * @author JhonnyTime and the knowlage i gained with the Patrick Collins course. Miguel de los Rios
 * @notice I explain the Script to trigger the fallback function in this contract.
 * @dev I explain it because there is no video in youtube yet on how to crack it using foundry, just the code of the solution of the script. So i had to figure it out by myself.
 */

contract Fallback {
    mapping(address => uint) public contributions;
    address public owner;

    constructor() {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    // FIRST STEP: This is the the first function we want to call, we send 1 wei which is less than 0.001 ether, so we claim ownership, after this we go to the receive function.
    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // SECOND STEP: Here we have two conditions to trigger the fallback function:
    // 1. We need to contribute with > 0. which we already did in the first step in the script.
    // 2. The second condition is that we need
    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}
