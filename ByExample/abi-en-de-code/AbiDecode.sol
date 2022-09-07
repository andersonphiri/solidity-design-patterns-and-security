// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AbiDecode {
    struct Customer {
        string name;
        uint[2] numInfor;
    }

    function encode(uint x, address addr, uint[] calldata arr, Customer calldata customer) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, customer);
    }
    function decode(bytes calldata data) external pure returns (
        uint x,
        address addr,
        uint[] memory arr,
        Customer memory customer

    ) {
        (x, addr, arr, customer) = abi.decode(data, (uint, address, uint[], Customer));
    }
}