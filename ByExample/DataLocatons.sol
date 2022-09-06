// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DataLocation {
    // storage means it reside on the blockchain, it a state variable
    // memory means is in memory and it exists while the function is being called
    // calldata: special data location that contains function arguments

    struct MyStruct {
        uint value;
    }

    function _f(uint[] storage _arr, mapping(uint => address) storage _map, MyStruct storage _myStruct) internal {

    }

    function g(uint[] memory _arr) public returns (uint[] memory) {

    }

    function h(uint[] calldata _arr) external {
        
    }
    
}