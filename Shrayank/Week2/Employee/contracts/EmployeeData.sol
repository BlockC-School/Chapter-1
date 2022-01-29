//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract EmployeeData {

  struct Employee {
    unint id;
    string name;
    string email;
    uint age;
    address walletAddress;
  }

  Emp[]  Employees;
  uint public next;

  //Create
  function addEmp (string memory _name, string memory _email, uint _age, string memory _wallet_address) public {
        empData.push(Employee(next, _name, _email, _age, _walletAddress));
        next++; 
  }
  //Read
  function getEmp (uint _id) public view returns (uint, string memory, string memory, uint, string memory) {
    
        
      return (empData[_id].id, empData[_id].name, empData[_id].email, empData[_id].age, empData[_id].wallet_address );
  }
  //Update 
  function updateEmp (uint _id, string memory _name, string memory _email, uint _age, string memory _wallet_address) public {
        // uint i = searchEmployee(_id);
        empData[_id].name = _name;
        empData[_id].email = _email;
        empData[_id].age = _age;
        empData[_id].wallet_address = _wallet_address;
  }
  //Delete  
  function deleteEmp (uint _id) public {
        uint i = _id;
        delete empData[i];
  }
}