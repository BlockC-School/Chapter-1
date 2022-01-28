//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// import "hardhat/console.sol";

contract EmployeeData {
    struct Employee {
        uint id;
        string name;
        string email;
        uint age;
        string wallet_address;
    }
    
    Employee[] public employeeArr;
    uint public nextId;
    
    function addEmployee (string memory _name, string memory _email, uint _age, string memory _wallet_address) public {
        employeeArr.push(Employee(nextId, _name, _email, _age, _wallet_address));
        nextId++; 
    }
    
    function getEmployee (uint _id) public view returns (uint, string memory, string memory, uint, string memory) {
        // uint i = searchEmployee(_id);
        // return (employeeArr[i].id, employeeArr[i].name, employeeArr[i].email, employeeArr[i].age, employeeArr[i].wallet_address );
        
        return (employeeArr[_id].id, employeeArr[_id].name, employeeArr[_id].email, employeeArr[_id].age, employeeArr[_id].wallet_address );
    }
    
    function updateEmployee (uint _id, string memory _name, string memory _email, uint _age, string memory _wallet_address) public {
        // uint i = searchEmployee(_id);
        employeeArr[_id].name = _name;
        employeeArr[_id].email = _email;
        employeeArr[_id].age = _age;
        employeeArr[_id].wallet_address = _wallet_address;
    }
    
    function deleteEmployee (uint _id) public {
        uint i = _id;
        delete employeeArr[i];
    }
    
    // function searchEmployee(uint _id) internal view returns (uint) {
    //     for(uint i = 0; i < employeeArr.length; i++){
    //         if(employeeArr[i].id == _id){
    //             return i;
    //         }
    //     }
    // }
}
