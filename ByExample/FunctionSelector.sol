// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FucntionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    "tranferFrom(address,address,uint256)"
    0x23b872dd
    */
    function getSelector(string calldata _func) public payable returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}