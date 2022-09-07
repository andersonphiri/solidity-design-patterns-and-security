// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Note: libraries must be deployed first then linked to contracts

library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y == 0 || y == 1) {
            return y;
        }
        uint start = 1;
        uint end = y;
        uint ans = start;
        while (start <= end) {
            uint mid = start + (end - start) / 2;

            if (mid**2 < y) {
                start = mid + 1;
                ans = mid;
            } else if (mid**2 > 1) {
                end = mid - 1;
            } else {
                return mid;
            }
        }
        return ans;
    }
}

contract TestMathLib {
    function testSquareRoot(uint _x) pure public returns (uint) {
        return Math.sqrt(_x);
    }
}

library Arrays {
     function deleteAt(uint[] storage arr, uint _index, bool preserveOrder) public returns (uint) {
        require(_index < arr.length, "index required is out of bounce");
        uint valueAt = arr[_index];
        if (preserveOrder) {
            deletePreserveOrder(arr,_index);
        } else {
            deleteWithNoPreserveOrder(arr,_index);
        }
        return valueAt;
    }
    function deletePreserveOrder(uint[] storage arr, uint _index) private {
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i+1];
        }
        arr.pop();
    }
    function deleteWithNoPreserveOrder(uint[] storage arr, uint _index) private {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract TestArraysLib {
    using Arrays for uint[];
    uint[] public list;
    function testDelete() public {
        list = [20, 40, 60, 80, 100];
        assert(list.length == 5);
        list.deleteAt(0, true);
        assert(list.length == 4);
        assert(list[0] == 40);
        assert(list[list.length - 1] == 100);
    }
}