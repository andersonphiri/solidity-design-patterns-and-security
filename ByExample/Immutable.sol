// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
immutable variable are simply, readonly but initializable inside ctor
 */

 contract Immutable {
    address public immutable MY_SENDER ;
    uint public  immutable MY_AGE;
    constructor(uint myAge) {
        MY_SENDER = msg.sender;
        MY_AGE = myAge;
    }
 }