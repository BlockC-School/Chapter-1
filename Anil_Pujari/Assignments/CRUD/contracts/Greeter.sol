//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract EmployeeDetails {
    struct Employee{
        string name;
        string email;
        uint age;
        string wallet;
        uint empID;
    }
    uint index;
    mapping(uint => Employee) employees;


    constructor() {
         console.log("Deploying a employee");
         index = 0;
    }


    function AddEmployee(string memory name,string memory email,uint age, string memory wallet) public returns (uint) {
        index = index + 1;
        employees[index].name = name;
        employees[index].email = email;
        employees[index].age = age;
        employees[index].wallet = wallet;
        employees[index].empID = index;
        return index;
    }

    function GetEmployee(uint empId) public view returns(string memory name, string memory email, string memory wallet, uint empID) {
        return (employees[empId].name , employees[empId].email, employees[empId].wallet, employees[empId].empID);
    }

     function UpdateEmployeeDetails(uint empId, string memory name,string memory email,uint age, string memory wallet) public returns (string memory) {
        employees[empId].name = name;
        employees[empId].email = email;
        employees[empId].age = age;
        employees[empId].wallet = wallet;
        employees[empId].empID = empId;
        return "Employee Updated";
    }

    function DeleteEmp(uint empID) public {
        delete employees[empID];
    } 
}
