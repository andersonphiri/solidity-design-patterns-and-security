// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Looping {
    function loop() public {
        for (uint i = 0; i < 40 ; i++) {
            
            if (i == 2) {
                continue;
            }

            if (i == 12) {
                break;
            }
        }
        // while loop
    uint j;
    while (j < 10) {
            j++;
        }
    }
    
}