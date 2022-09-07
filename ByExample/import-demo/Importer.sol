// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./ToBeImported.sol"; // for contracts

// you can also import from git**b
// import "https://gitlab.com/chitataunga/path/to/contractfile/contractfilename.sol"
// import "https://github.com/andersonphiri/path/to/contractfile/contractfilename.sol"

import { UnAuthorized, add as func , Point } from "./ToBeImported.sol";


contract Importer {
    Foo public foo = new Foo();
    function getFooName() public view returns (string memory) {
        return foo.name();
    }

    function adder(uint x, uint y) pure public returns (uint) {
        return func(x,y);
    }
}