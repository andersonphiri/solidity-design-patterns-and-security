// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HashFunction {
    
    function hash(string memory _text, uint _num, address _addr ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text,_num, _addr));
    }
    // collisions may happen if you pass more than one dynamic data type, in that case use abi.encode
    function collision(string memory _text1, string memory _text2) public pure returns (bytes32) {
        return keccak256(abi.encode(_text1, _text2));
    }   

   

}

 // checking hash value
contract CheckTheHash {
    bytes32 public answer = 0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;

    function checkWord(string memory _word) public view returns (bool) {
        return keccak256(abi.encodePacked(_word)) == answer ;
    }
}