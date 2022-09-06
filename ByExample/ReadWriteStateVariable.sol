// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ReadWriteStateVariable {
    uint public age;

    // you need to send a transaction  to set state variable
    function setAge(uint _age) public {
        age = _age;
    }

    // you can read from state variable without sending a tx
    function getAge() public view returns (uint) {
        return age;
    }
}