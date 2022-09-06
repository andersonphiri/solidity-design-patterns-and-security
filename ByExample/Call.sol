// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Rceiver {
    event Received(address caller, uint amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "fallback was called!");
    }

    function foo(string memory _message, uint x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);
        return x + 1;
    }

}

contract Caller {
    event Response(bool success, bytes data);

    function testCallFoo(address payable _addr) public payable {
        // you can send ether and specify custom gas amount
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "calling foo from caller contract", 123)
        );
        emit Response(success, data);
    }

    // the following function call will trigger fallback because the contract does not contain a method with name:
    // thisFunctionDoesNotExist()
    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("thisFunctionDoesNotExist()"));
        emit Response(success, data);
    }
}