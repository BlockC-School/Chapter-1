//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Employee {
   
   struct EmployeeData {
       string name;
       uint age;
       string email;
       address walletAddress;
       uint unique;
   }

   EmployeeData[] public arr;

   uint public id;

   constructor() public {
       id = 0;
   }

  function addEmployeeData(string memory _name, uint _age, string memory _email, address _walletAddress) public {
      EmployeeData memory emp = EmployeeData(_name, _age, _email, _walletAddress, id);
      arr.push(emp);
      id = id + 1;
  }

  function getOneEmployee(uint _id) public view returns(EmployeeData memory) {
      return arr[_id];
  }

  function getAllEmployeeData() public view returns(EmployeeData[] memory){
      return arr;
  }

  function editEmployeeData(uint _id, string memory _name, uint _age, string memory _email, address _walletAddress ) public {
      EmployeeData storage emp = arr[_id];
      emp.name = _name;
      emp.age = _age;
      emp.email = _email;
      emp.walletAddress = _walletAddress;
  }

  function deleteEmployeeData(uint _id) public {
      delete arr[_id];
  }

}
