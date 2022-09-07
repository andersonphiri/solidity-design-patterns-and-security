// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


interface IERC20 {
    function transfer(address, uint) external;
}
contract AbiEncode {
    function encodeWithSignature(address to, uint amount) external pure returns (bytes memory) {
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    function encodeWithSelector(address to, uint amount) external pure returns (bytes memory) {
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodeWithCall(address to, uint amount) external pure returns (bytes memory) {
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}