// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// custom errors:

error InsufficientBalance(uint balance, uint withdrawalAMount);
contract Errors {
    uint public num;
    uint public balance;
    


    function testRevert(uint _i) public pure {
        if (_i <= 9) {
            revert("input must be more than 9");
        }
    }

    function testAssert() public view {
        // do stuff here
        assert(num == 0);
    }

    function testCustomErrors(uint _withdrawalAmount) public view {
        uint bal = (address(this)).balance;
        if (bal <= _withdrawalAmount) {
            revert InsufficientBalance(bal, _withdrawalAmount);
        }
    }

    function deposit(uint _amount) public {
        uint oldBalance  = balance;
        uint newBalance = _amount + balance;
        require(newBalance >= balance, "overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }

    function withraw(uint _amount) public {
        uint oldBalance  = balance;
        require(balance >= _amount, "Underflow");
        if (balance < _amount) {
            revert("Underflow");
        }
        balance -= _amount;
        assert(balance <= oldBalance);
    }
}