// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;



// https://solidity-by-example.org/sending-ether/

    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()

How to send gas:
- transfer: (2300 gas, throws error)
- send: (2300gas, returns bool)
- call: (forward all gas or set gas, returns bool)

How to receive ETHER:
- receive() external payable
- fallback() external payable

WHAT TO USE ?
- it is recomended to use call in combination with re-entrancy guard

    */

contract ReceiveEther {

    // Function to receive ether. msg.data must be empty
    receive() external payable { } 

    // function to receive ether when msg.data is not empty
    fallback() external payable { }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
}

contract SendEther {
    // the first two options are no longer recomended ways to send ether, i.e, use of transfer and send


    // no longer recomended
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    // no longer recomended
    function sendViaSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "failed to send ether");
    }

    // send via call, currently recomended way
    function sendViaCall(address payable _to) public payable {
        (bool sent, /*bytes memory data*/ ) = _to.call{value: msg.value}("");
        require(sent, "failed to send ether");
    }
}