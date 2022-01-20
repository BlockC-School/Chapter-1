// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "hardhat/console.sol";

contract Employe {
    uint id;
    string name;
    string email;
    uint age;
    address wallets;

    function Employee(uint _id, string memory  _name, string memory _email, uint _age, address _walletAddress) public {
        id = _id;
        name = _name;
        age = _age;
        email = _email;
        wallets = _walletAddress;
    }

    function getId(string memory _name) public view returns (uint) {
        return id;
    }

    function getEmployee(uint _id) public view returns (uint, string memory, string memory, uint, address) {
        return (id, name, email, age, wallets);
    }
    
    function getDetails() public view returns (uint, string memory, string memory, uint, address) {
        return (id, name, email, age, wallets);
    }
    function deleteDetails() public {
        id = 0;
        name = "";
        email = "";
        age = 0;
        wallets = address(0);
    }
}