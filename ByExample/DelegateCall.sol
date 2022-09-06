// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


// delegatecall is similar to call
contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

// to do a delegatecall the struct layout must be the same for both contracts

contract A {
     uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        
    }
}