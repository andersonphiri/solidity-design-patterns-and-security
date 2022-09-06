// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Enum.sol";
contract Enum {
    Status public status;

    function getStatus() public view returns (Status) {
        return status;
    }

    function setStatus(Status _status) public {
        status = _status;
    }
    function cancel() public {
        status = Status.Canceled;
    }
    function resetStatus() public {
        delete status; // sets it to zero value
    }
}