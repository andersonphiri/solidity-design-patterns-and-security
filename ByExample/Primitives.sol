// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// https://solidity-by-example.org/primitives/
// https://ethereum-blockchain-developer.com/2022-01-remix-introduction/00-overview/

contract Primitives {
    bool public boo = false;
    // unsigned ints: uintN ranges from  0 ... to (2^N)-1
    uint public u256 = 323; // uint is alias for uint256
    uint8 public u8 = 8; // uint

    // signed ints: intN ranges from (-2^(N-1)) ... to  (2^(N-1) - 1)
    int public i256 = 898; // default for int 256

    int80 public i8 = -8989;

    // minimum and maximum of int
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    // address default: 0x0000000000000000000000000000000000000000
    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    // byte arrays: byte1N is a byte array of sizeN: 
    bytes1 a = 0xb5;
    bytes2 b = 0x00AE;





    


}