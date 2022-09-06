// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract A {
    function doStuff() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function doStuff() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    function doStuff() public pure virtual override returns (string memory) {
        return "C";
    }
}


// Contracts can inherit multiple cotracts
// when a function is defined in multiple paent contracts, 
// parent contracts are searched from right to left in the order of specified inheritance in a depth first manner

contract D is  B, C {
    function doStuff() public pure override(B, C) returns (string memory) {
        return super.doStuff(); // returns  "C"
    }
}

contract E is C, B {
    function doStuff() public pure override(C, B) returns (string memory) {
        return super.doStuff(); // returns  "B"
    }
}

// inheritance must be ordered from "most-base-like" to most derived
// swapping the order of A and B below will throw compilation error
contract F is A, B {
    function doStuff() public pure override(A, B) returns (string memory) {
        return super.doStuff(); // returns  "B"
        // or
        // return  B.doStuff();
    }
    string public name ;
}

contract G is F {
    constructor() {
        name = "G ctor";
    }

}