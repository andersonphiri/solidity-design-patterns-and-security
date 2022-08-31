pragma solidity >= 0.7.0;

// use checks-effects-interactions pattern when interacting with external parties

// Insecure contract

contract UnsafeFund {
    mapping(address => uint) userBalances;
    function withdrawBalance() public {
        // external call 
        if (msg.sender.call.value(userBalances[msg.sender])())
          userBalances[msg.sender] = 0 ;
    }
}
contract Exploiter {
    UnsafeFund f;
    uint public count;
    event LogWithdrawFallback(uint c, uint balance);
    function () public payable {
        count++;
        emit LogWithdrawFallback(count, address(f).balance);
        if (count < 10) {
            f.withdrawBalance();
        }
    }
}


contract SafeFund {
    mapping(address => uint) userBalances;

}