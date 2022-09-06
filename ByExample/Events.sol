// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Events {

    // event declaration
    // up to 3 parameters can be indexed
    // indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event SomeLog();

    function test() public {
        emit Log(msg.sender, "Hi There!");
        emit SomeLog();
    }
    
}