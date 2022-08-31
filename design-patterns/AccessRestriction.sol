pragma solidity >= 0.7.0;

// Access Restriction  Pattern
contract Ownable {
    address owner;
    uint public initTime = block.timestamp;
    constructor() {
        owner = msg.sender;
    }
    // check if the caller is the owner of the contract
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner Allowed.");
        _;
    }
    // change the owner of the contract
    // @param _newOwner the address of the new owner of the contract.
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    function getOwner() view internal returns (address) {
        return owner;
    }

    modifier onlyAfter(uint _time) {
        require(block.timestamp >= _time, "Not enough ether provided.");
        _;
    }
    modifier costs(uint _amount) {
        require(msg.value > _amount, "Not enough ether proviude.");
        _;
        if (msg.value > _amount)
        msg.sender.transfer(msg.value - _amount);
    }

}

contract SampleContract is Ownable {
    mapping(bytes32 => uint) myStorage;
    constructor () public {

    }
    function getValue(bytes32 record) constant public returns (uint) {
        return myStorage[bytes32];
    }

    function setValue(bytes32 record, uint value) public onlyOwner {
        myStorage[record] = value;
    }

    function forceOwnerChange(address _newOrder) public 
    payable onlyOwner onlyAfter(initTime + 2 weeks) costs(50 ether)
    {
        owner = _newOrder;
        initTime = block.timestamp;
    }


}