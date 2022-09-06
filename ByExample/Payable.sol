// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {
    address payable public owner;
    constructor () {
        owner = payable(msg.sender);
    }

    // Function to deposit ether into this contract
    // call this func with some ether and the balance will automatically updated

    function deposit() public payable { }

    // call this function with some Ether will not work
    function notPayable() public { }

    function withdraw() public {
        // get the amount of ether stored on this contract
        uint amount = address(this).balance;
        // send all ether to owner
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send ether");
    }

    function transfer(address payable _to, uint _amount) public {
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "failed to send ether");
    }


}