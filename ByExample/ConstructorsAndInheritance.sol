// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// base ctor
contract X {
    string public name;
    constructor (string memory _name) {
        name = _name;
    }

}

// base ctor
contract Y {
    string public text;
    constructor (string memory _text) {
        text = _text;
    }
    
}

contract B is X("x input"), Y("input to Y") {

}

// parent ctors are always called in order of specified inheritance
// in C below, X ctor is called first, then Y, then lastly C
contract C is X,Y {
    constructor (string memory _name, string memory _text) Y(_text) X(_name)  { }
}