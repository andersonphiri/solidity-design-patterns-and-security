// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Arrays {
    // there are several ways to initialize an array
    uint[] public arr; // dynamically sized array
    uint[] public arr2 = [1,5,9];
    // fixed sized arrays
    uint[20] public myFixedSizeArray; // all elements are initalized to zero

    function getAt(uint _index) public view returns (uint) {
        require(_index < arr.length, "index required is out of bounce");
        return arr[_index];
    }

    function push(uint _value) public {
        arr.push(_value);
    }
    function pop() public returns (uint) {
        uint last = arr[arr.length - 1];
        arr.pop();
        return last;
    }
    function getLength() public view returns (uint) {
        return arr.length;
    }

    function resetValueAt(uint _index) public {
        require(_index < arr.length, "index required is out of bounce");
        delete arr[_index]; // sets value to default
    }

    function deleteAt(uint _index, bool preserveOrder) public returns (uint) {
        require(_index < arr.length, "index required is out of bounce");
        uint valueAt = arr[_index];
        if (preserveOrder) {
            deletePreserveOrder(_index);
        } else {
            deleteWithNoPreserveOrder(_index);
        }
        return valueAt;
    }
    function deletePreserveOrder(uint _index) private {
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i+1];
        }
        arr.pop();
    }
    function deleteWithNoPreserveOrder(uint _index) private {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }


    // a function that returns array
    function getArray() public view returns (uint[] memory) {
        return arr;
    }

    function examples() external pure {
        uint[] memory a = new uint[](5); // fixed array size
    }

    function test() external  {
        arr = [20, 40, 60, 80, 100];
        assert(arr.length == 5);
        deleteAt(0, true);
        assert(arr.length == 4);
        assert(arr[0] == 40);
        assert(arr[arr.length - 1] == 100);
    }

}