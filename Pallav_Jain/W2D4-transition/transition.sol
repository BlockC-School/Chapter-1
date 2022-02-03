//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

contract Transaction {
	uint amount;
    address payable receiver; 

    function payEther() public payable {
    }

    function getBalance() public view  returns (uint) {
        return address(this).balance;
    }

    function sentEtherToAccount(uint _amount, address payable _receiver) public payable {
       address payable user = _receiver;
       user.transfer(_amount);
    }
}