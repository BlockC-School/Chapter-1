//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract EmployeeDictionary {

  struct Emp {
    string name;
    string email;
    uint age;
    address walletAddress;
  }

  Emp[]  Employees;

    //Add an Employee
  function addEmployee(string memory _name, string memory _email, uint _age, address _walletAddress) public returns(uint) {
    Emp memory employee;
    employee.name = _name;
    employee.email = _email;
    employee.age = _age;
    employee.walletAddress = _walletAddress;
    Employees.push(employee);
    return Employees.length;
  }

    //Get an Employee Details
  function getEmployee(uint _id) public view returns(Emp memory) {
    return Employees[ _id-1 ];
  }
    //Get All Employees Details
  function getAllEmployees() public view returns(Emp[] memory) {
    return Employees;
  }

    //Delete a particular Employee 
  function deleteEmployee(uint _id) public {
    delete Employees[_id-1];
  }

  //Modify a particular Employee
  function modifyEmployee(uint _id, string memory _name, string memory _email, uint _age, address _walletAddress) public  {
    Employees[_id-1].name = _name;
    Employees[_id-1].email = _email;
    Employees[_id-1].age = _age;
    Employees[_id-1].walletAddress = _walletAddress;
  }
}