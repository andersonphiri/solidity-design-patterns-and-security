pragma solidity >= 0.7.0;

interface ITest {
    function run() external ;
    event Approval(address indexed owner, address indexed spender, uint value); 
    event Transfer(address indexed owner, address indexed spender, uint value); 
}

// OOP Design
contract Animal {
  constructor() public {

  }
  function name() public returns(string) {
    return "Animal";
  }
}

contract Mammal is Animal {
  uint size;
  constructor() public {

  }
  function name() public returns (string) {
     return "Mammal";
  }
  function run() public pure returns (int) {
    return 10;
  }
  function color() public returns (string);

}

contract Dog is Mammal {
  function name() public returns (string) {
    return "Dog";
  }
  function color() public returns (string) {
    return "Black";
  }
}

// interface: similar to Abstract class but with more restrictions:
contract A {
  function doStuf() public returns (string);
}