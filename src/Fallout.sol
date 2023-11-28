// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

//  Objective:
//  Claim ownership of the contract below to complete this level.

// I think they didnt even bother to update this challenge to a newer version of the compiler because if you want to use a constructor, now its mandatory to use the keyword constructor instead of the contract name.So this vulnerability is not even possible anymore.

// So unless the dev is somehow using 0.6.0, which would be very dumb.
/* You just need to call the constructor that is not named the same as the contract, which was possible in 0.6.0 compiler */

contract Fallout {
    mapping(address => uint256) allocations;
    address payable public owner;

    /* constructor */
    function Fal1out() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function allocate() public payable {
        allocations[msg.sender] += (msg.value); // had to update safemath from .add to + because of the compiler version.
    }

    function sendAllocation(address payable allocator) public {
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return allocations[allocator];
    }
}
