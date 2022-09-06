// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Modifiers {
    address public  owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // underscore mens execute the rest of code
        _;
    }
    modifier validAddress(address _addr) {
        require(_addr != address(0), "invalid address");
        _;

    }

    modifier noReEntrancy() {
        require(!locked, "function is still executing");
        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReEntrancy {
        x -= i;
        if (i > 1) {
            decrement(i - 1);
        }
    }

    function changeOwner(address newOwner) public onlyOwner validAddress(newOwner) {
        owner = newOwner;
    }
}