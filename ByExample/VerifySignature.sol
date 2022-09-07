// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
Signing:
1. create a message to sign
2. Hash the message
3. sign the hash (off chain, keep your private key secret)

Verifying:
1. Recreate the hash from the original message
2. Recover signer from signature and hash
3. Compare the claimed signer and the recovered signer
*/

contract VerifySignature {
    // inside eth.build sandbox( https://sandbox.eth.build/ ), this can be simulated as follows:
    // 1. button -> Key Pair ->
    // 2. Text -> SIGN(use private key from 1) -> ADDRESS (2)
    // 3. Text -> RECOVER(use signature from 2 above) -> ADDRESS (3)
    // 4. the values of ADDRESS (2) and ADDRESS (3) should be the same

    function computeMessageHash(address _to, uint _amount, string memory _message, uint _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    function  recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature) public pure returns (address) {
        (bytes32 r,
        bytes32 s,
        uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function verify(address _signer, address _to, uint _amount, string memory _message,  uint _nonce, bytes memory _signature) public pure returns (bool) {
        bytes32 messageHash = computeMessageHash(_to, _amount, _message, _nonce);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recoverSigner(ethSignedMessageHash, _signature) == _signer;
    }

    function splitSignature(bytes memory _signature) public pure returns (
        bytes32 r,
        bytes32 s,
        uint8 v
    ) {
        require (_signature.length == 65, "invalid signature length");
        assembly {
             /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */
            r := mload(add(_signature, 32))
            s := mload(add(_signature, 64))
            v := byte(0, mload(add(_signature, 96))) 
        }
    }
}
