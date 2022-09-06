// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// maps are not iterable
contract Mapping {
    mapping(address => uint) public myMap;
    function get(address addr) public view returns (uint) {
        return myMap[addr];
    }
    function set(address addr, uint _i) public {
        myMap[addr] = _i;
    }
    function remove(address _addr) public {
        delete myMap[_addr];
    }
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) nested;
    function get(address _addr, uint _i) public view returns (bool) {
        return nested[_addr][_i];
    }
    function remove(address _addr, uint _i) public {
        delete nested[_addr][_i];
    }

    function set(address _addr, uint _i, bool _value ) public {
        nested[_addr][_i] = _value;
    }

}