// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BitwiseOperations {
    function and(uint x, uint y) external pure returns (uint) {
        return x & y;
    }

    function or(uint x, uint y) external pure returns (uint) {
        return x | y;
    }

    function xor(uint x, uint y) external pure returns (uint) {
        return x ^ y;
    }

    function not(uint x) external pure returns (uint) {
        return ~x;
    }

    // 1 << 0 = 0001 --> 0001 = 1
    // 1 << 1 = 0001 --> 0010 = 2
    // 1 << 2 = 0001 --> 0100 = 4
    // 1 << 3 = 0001 --> 1000 = 8
    // 3 << 2 = 0011 --> 1100 = 12
    function shiftLeft(uint x, uint bits) external pure returns (uint) {
        return x << bits;
    }

    // 8  >> 0 = 1000 --> 1000 = 8
    // 8  >> 1 = 1000 --> 0100 = 4
    // 8  >> 2 = 1000 --> 0010 = 2
    // 8  >> 3 = 1000 --> 0001 = 1
    // 8  >> 4 = 1000 --> 0000 = 0
    // 12 >> 1 = 1100 --> 0110 = 6
    function shiftRight(uint x, uint bits) external pure returns (uint) {
        return x >> bits;
    }

    // returns the value of the last N bits of x
    // if x = 4, n = 2, then last 2 bits of 100 are 00 = 0

    function getLastNbits(uint x, uint n) external pure returns (uint) {
        // Example, last 3 bits
        // x        = 1101 = 13
        // mask     = 0111 = 7
        // x & mask = 0101 = 5
        uint mask = (1 << n) - 1; // if n == 3, mask = (1 << 3) - 1 = (1000) - 1 = 0111 = 111
        return mask & x;
    }

    // bits are zero indexed fro right to left, where the most right is the most significant
    // for example: x = 10 = 1100 , the msb = 3,ie msb is at position 3
    function mostSignificantBitPosition(uint x) external pure returns (uint) {
        return mostSignificantBitPositionUtil(x);
    }

    function mostSignificantBitPositionUtil(uint x) private pure returns (uint) {
        uint i = 0;
        while ((x >>= 1) > 0) {
            ++i;
        }
        return i;
    }

    function mostSignificantBitPositionWithBinarySearch(uint x) external pure returns (uint8 r) {

        // if x >= 2**128
        if (x >= 0x100000000000000000000000000000000) {
            x >>= 128;
            r += 128;
        }

        // if x >= 2**64
        if (x >= 0x10000000000000000) {
            x >>= 64;
            r += 64;
        }

        // if x >= 2**32
        if (x >= 0x100000000) {
            x >>= 32;
            r += 32;
        }

        // if x >= 2**16
        if (x >= 0x10000) {
            x >>= 16;
            r += 16;
        }

        // if x >= 2**8
        if (x >= 0x100) {
            x >>= 8;
            r += 8;
        }

        // if x >= 2**4
        if (x >= 0x10) {
            x >>= 4;
            r += 4;
        }

        // if x >= 2**2
        if (x >= 0x4) {
            x >>= 2;
            r += 2;
        }

        // if x >= 2**1
        if (x >= 0x2) {
            r += 1;
        }
    }

    modifier canGetFirstNBitsValue(uint n, uint _numberOfBitsInX) {
        require(n <= _numberOfBitsInX, "the value of n should be at most number of bits in x");
        _;
    }

    function getFirstNBitsValueUtil(uint x, uint n, uint _numberOfBitsInX) private pure canGetFirstNBitsValue(n,_numberOfBitsInX) returns (uint) {
        // aproach:
        // 1. compute mask of first n bits:
        //      1a. compute last n bits mask: (1 << n) -1
        //      1b. left shift the result in 1a by diff(i.e by _numberOfBitsInX - n): 1a << (_numberOfBitsInX - n)
        // 2. return result form step 1 & x
        uint mask = ((1 << n) - 1) << (_numberOfBitsInX - n);
        return mask & x;
    }

    function getFirstNBitsValue(uint x, uint n) external pure returns (uint) {
        uint _numberOfBitsInX = mostSignificantBitPositionUtil(x) + 1;
        return getFirstNBitsValueUtil(x, n, _numberOfBitsInX);
    }

    // todo: count set bits
    uint8[256] private   _lookup;
    constructor () {
        _lookup[0] = 0;
        uint8 i = 1;
        for (; i < 255;  ) { // loop up to 254 to evade overflows with ++i
            _lookup[i] = (i &1) + _lookup[i / 2];
            unchecked {
                ++i;
            }
        }
        _lookup[0xFF] = 8;
    }

    function countSetBits(uint x) external  view returns (uint) {
         // 10001111
         uint result = _lookup[x & 0xFF];
         while ((x >>= 8) > 0) {
            result += _lookup[x & 0xFF];
         }
         return result;
    }



}