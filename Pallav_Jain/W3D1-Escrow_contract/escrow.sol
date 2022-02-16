// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Escrow_contract {
    address public user_A;
    bool public work_done;
    uint amount;
    bool public is_paid;
    address payable user_B; 

    constructor(uint _amount) payable {
        user_A = msg.sender;
        amount = _amount;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    modifier work() {
        require(work_done, "Work Not Done, Please done the work first");
        work_done = false;
        _;
    }

     modifier paid() {
        require(!is_paid, "User B is Already Paid");
        _;
        is_paid = true;
    }

    function getBalance() public view  returns (uint) {
        return address(this).balance;
    }

    function WorkDonebyUser_B() public returns (bool) {
       work_done = true;
       return work_done;
    }

    function sentEtherToUser_B(uint _amount, address payable _user_B) public payable validAddress(_user_B) paid work {
        address payable user = _user_B;
        user.transfer(_amount);
    }
}