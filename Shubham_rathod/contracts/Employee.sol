//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Employee {
    struct EmployeeStruct {
        uint256 id;
        string name;
        string email;
        uint256 age;
        string wallet;
    }

    uint256 uuid;

    EmployeeStruct[] employees;

    EmployeeStruct employeeData;

    constructor() {
        // name = _name;
        console.log("it ran");
    }

    function createEmployee(EmployeeStruct memory _Employee)
        public
        returns (uint256)
    {
        uuid = _Employee.id;
        employeeData = EmployeeStruct(
            _Employee.id,
            _Employee.name,
            _Employee.email,
            _Employee.age,
            _Employee.wallet
        );
        employees.push(employeeData);
        return (uuid);
    }

    function getEmployee(uint256 id)
        public
        view
        returns (EmployeeStruct memory)
    {
        for (uint256 i = 0; i < employees.length; i++) {
            if (employees[i].id == id) {
                return (employees[i]);
            }
        }
    }

    function updateEmployee(uint256 id, EmployeeStruct memory _UpdatedEmployee)
        public
        returns (EmployeeStruct memory)
    {
        for (uint256 i = 0; i < employees.length; i++) {
            if (employees[i].id == id) {
                employees[i] = _UpdatedEmployee;
                return (employees[i]);
            }
        }
    }

    function getAllEmployee() public view returns (EmployeeStruct[] memory) {
        return employees;
    }

    function deleteEmp(uint256 id) public returns (string memory) {
        delete employees[id];

        return ("employee got deleted");
    }
}
