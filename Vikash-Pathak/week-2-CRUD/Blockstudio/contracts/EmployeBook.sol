// SPDX-Licence-idendifier: Unlicense

pragma solidity ^0.8.0;

contract ledger{
    struct Employee {
        uint id;
        string name;
        string email;
        address wallet;
        uint age;
    }
    // create an array of structs
    // uint id, string memory name, string memory email, uint256 wallet, uint age, uint salary

    // Employee public employe;
    Employee[] public employees;
    mapping(address => Employee[]) public EmpBook;

    // create a function to add employee details
    function addEmployee() external {
        Employee memory ramesh = Employee({id: 3,name:'ramesh',email: 'kamu@gmail',wallet: 0x5Bd49bF9F37FFc2c5fFD3405818e4cfAA4A987CD,age: 21});
        Employee memory ramu;
        ramu.name = 'ramu';
        ramu.email = "ramu@gmail";
        employees.push(ramu);
        employees.push(ramesh);
        employees.push(Employee(13,'shyam', 'shyam@gmail', 0x5Bd49bF9F37FFc2c5fFD3405818e4cfAA4A987CD , 33));

        Employee storage _employe = employees[0];
        delete _employe.name;
        delete employees[1];
    }

    // create a function to get employee details
    function getEmployee(uint id) public view returns (string memory ) {
        return employees[id].name;
    }
}
// pragma experimental ABIEncoderV2;
// contract SavingsAccount {
//   struct Member{
//     uint id;
//     string name;
//     uint balance;
//   }
//   mapping (uint => Member) public members;
//   event savingsEvent(uint indexed _memberId);
//   uint public memberCount;
// }  