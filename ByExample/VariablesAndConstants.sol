// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
variables are three types:
- State variables: 
    - stored on the blockchain
    - declared outside functions
Local variables:
    - declared inside function
    - not stored on blockchain

global variables: provides information about the blockchain


 */
contract Variables {
    // state variable
    string public text = "anderson";
    // state variable
    uint public num = 2456;

    function doStuff() public {
        int a = 99; // local variable
        // global vars
        uint timestamp = block.timestamp;
        // sender's address
        address  sender = msg.sender;

    }
    

    // constants 
    address public constant MY_ADDRESS = 0x0000000000000000000000000000000000000000;
    uint public constant MY_AGE = 0x20;
}