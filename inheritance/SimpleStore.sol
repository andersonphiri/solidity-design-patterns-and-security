pragma solidity >= 0.7.0;

contract SimpleStore {
  enum Color {BLUE,GREEN,YELLOW,GREEN}
  struct Student {
    uint age;
    string firstName;
    string lastName;
    string email;
  }
  mapping (address => Student) students;
  address[] public studentAccounts;
  function set(uint _value) public {
    value = _value;
  }

  constructor() public {
    value = 7000;
    color = Color.BLUE;
    admin = msg.sender;
  }

  function buy() public payable {
    value += msg.value;
  }
  function get() public constant returns (uint) {
    return value;
  }
  function getColor() public view returns (uint) {
    return uint(color);
  }
  function setColor(uint _value) {
    color = Color(_value);
  }

  function setStudent(address _address, uint age, string _firstName, string _lastName, string _email) public {
    Student storage student = students[_address];
    student.firstName = _firstName;
    student.lastName = _lastName;
    student.email = _email;
    studentAccounts.push(_address) -1;
  }

  function getStudents() view public returns(address[]) {
    return studentAccounts;
  }

  function getStudent(address _address) view public returns (uint,string,string,string) {
      return (students[_address].age,
      students[_address].firstname,
      students[_address].lastName,
      students[_address].email);
  }

  func countStudents() public returns (uint) {
    return studentAccounts.length;
  }

  uint value;
  Color color;
  address public admin;

  // custom modifiers
  modifier onlyAdmin() {
    // if condition is not met then throw an exception
    if (msg.sender != admin) revert();
    // or else just continue executing the function
    _;
  }
  // apply the custom modifier
  function kill() onlyAdmin public {
    selfdestruct(admin);
  }

  // events 
  event buyEvent(address bidder, uint amount); // Event

  function buy() public payable {
    emit buyEvent(msg.sender, msg.value)
  }
}