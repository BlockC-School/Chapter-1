// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract employeeCrudOperations{
    struct employee {
        uint id;
        string name;
        uint age;
        string email;
        address walletAddress;
    }
    employee[] emp; // dynamic array to store employees records
    function addEmployee(uint _id,string memory _name,uint _age,string memory _email,address _walletAddress) public returns(uint) {
        employee memory newEmp = employee(_id,_name,_age,_email,_walletAddress); 
       emp.push(newEmp);
       return _id;
    }
    function empSearch(uint empId) public view returns (string memory _name,uint _age,string memory _email,address _walletAddress){
        uint i;
        for(i=0;i<emp.length;i++){
            employee memory newEmp = emp[i];
        if(newEmp.id==empId){
        return (newEmp.name, newEmp.age, newEmp.email, newEmp.walletAddress);
        }
        }
    }
    function empRemove(uint empId) public {
        uint i;
        for(i=0;i<emp.length;i++){
            employee memory newEmp = emp[i];
        if(newEmp.id==empId){
        delete emp[i];
        }
        }
    }
    function allEmp() public pure returns (string memory employee ) {
        
        return employee;
    }
    function editEmp(uint empId,string memory _empName) public view  returns (string memory){
        uint i;
        for(i=0;i<emp.length;i++){
            employee memory newEmp = emp[i];
        if(newEmp.id==empId){
        return (newEmp.name=_empName);
        }
        }
    }

}