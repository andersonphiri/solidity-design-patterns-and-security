// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
/*
Gas optimisation techniques:
- Replacing memory with calldata
- Loading state variable to memory
- Replace loop i++ with ++i
- caching array elements
*/

contract OptimiseGas {
    uint public total;

    // not gas optimised
    function sumIfEvenAndLessThan100_MoreGas_AndLessOptimal(uint[] memory nums) external {
        for (uint i = 0; i < nums.length; i++) {
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan100 = nums[i] < 100;
            if (isEven && isLessThan100) {
                total += nums[i];
            }
        }
    }

    // gas optimised 
    function sumIfEvenAndLessThan100(uint[] memory nums) external {
        uint _total = total;
        uint n = nums.length;
        
        for (uint i = 0; i < n;  ) {

            uint num = nums[i];
            
            if ((num & 1 == 0) && num < 100) {
                _total += num;
            }
            unchecked {
                ++i;
            }
            total = _total;
        }
    }
}