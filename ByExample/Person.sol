// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./PersonStructDeclaration.sol";

contract Persons {
    Person[] public people;
    function addPerson(string calldata _name, uint _age, bool _graduated) public {
        people.push(Person(_name, _age, _graduated));
    }
    function addPersonOptionTwo(string calldata _name, uint _age, bool _graduated) public {
        people.push(Person({name: _name, age: _age, graduated: _graduated}));
    }
    function addPersonOptionThree(string calldata _name, uint _age, bool _graduated) public {
        Person memory person;
        person.name = _name;
        person.age = _age;
        person.graduated = _graduated;
        people.push(person);
    }

    // getters:
    function get(uint _index) public view returns (string memory name, uint age, bool graduated ) {
        require(_index < people.length, "index out of bounce");
        Person storage person = people[_index];
        return (person.name, person.age, person.graduated);
    }

    function updatePersonName(uint _index, string calldata name) public {
        require(_index < people.length, "index out of bounce");
        Person storage person = people[_index];
        person.name = name;
    }
    function toggleGraduated(uint _index) public {
        require(_index < people.length, "index out of bounce");
        Person storage person = people[_index];
        person.graduated = !person.graduated;
    }
}