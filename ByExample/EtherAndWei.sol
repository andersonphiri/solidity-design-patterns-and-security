// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
1 ETHER = 10^18 wei 
*/

contract EtherUnits {
    uint public oneWei = 1 wei;
    // one way is equal to 1
    bool public isOneWei = 1 wei == 1;

    uint public oneEther = 1 ether;
    bool public isOneEther = 1 ether == 10**18; // 1e18;
}