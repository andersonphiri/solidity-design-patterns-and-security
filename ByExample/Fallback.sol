// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
fallback is executed when:
- a function that does not exist is called or
- Ether is send directly to a contract but receive() does not exist or msg.data is not empty
- fallback has 2300 gas limit when called by transfer or send
*/

contract Fallback {
    event Log(uint gas);
    fallback() external payable {
        // send or transfer forwards 2300 gas to this fallback function
        // call forwards all gas
        emit Log(gasleft());
    }
    receive() external payable {
        emit Log(gasleft());
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Failed to send ether");
    }
}