//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract CRUD {
    struct Employee {
        uint id;
	    string name;
	    string email;
	    uint age;
        address walletAddress;
    }   

    Employee[] public Employees;
    uint public nextid;

    function CreateEmployee(string memory _name, string memory _email, uint _age, address _walletAddress) public {
        Employees.push(Employee(nextid, _name, _email, _age, _walletAddress));
        nextid++;
    }  

    function ReadEmployee(uint _id) public view returns(uint, string memory, string memory, uint, address ) {
        uint i = FindEmployee(_id);
        return (Employees[i].id, Employees[i].name, Employees[i].email, Employees[i].age, Employees[i].walletAddress);
    }

    
    function UpdateEmployee(uint _id, string memory _name, string memory _email, uint _age, address _walletAddress) public {
        uint i = FindEmployee(_id);
        Employees[i].name = _name;
        Employees[i].email = _email;
        Employees[i].age = _age;
        Employees[i].walletAddress = _walletAddress;    
    }

    function DeleteEmployee(uint _id) public {
        uint i = _id;
        delete Employees[i];
    }

    function FindEmployee(uint _id) internal view returns(uint) {
        for(uint i = 0; i < Employees.length; i++) {
            if(Employees[i].id == _id) {
                return i;
            }
        }

        // Employees.map((e) => {
        //     if(e.id == _id) {
        //         return e.id;
        //     }
        // })

    }
    
}
