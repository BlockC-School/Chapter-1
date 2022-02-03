//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.6;

contract EscrowContract {

    address public user_A;
    address payable public user_B;
    bool public workDone;
    uint public contractAmount;
    bool public isPayed;

    constructor () public {
        user_A = msg.sender;
    }

    function addFunds () public payable {
        require(msg.sender == user_A, "Not Authorized to Add Funds !!");
        require(address(this).balance <= contractAmount, "Should not add more than contract amount !!");
    }

    function createContract (address payable _user_B, uint _amount) public {
        require(msg.sender == user_A, "You can't create contract");
        user_B = _user_B;
        contractAmount = _amount;
        isPayed = false;
        workDone = false;
    }

    function submitWork () public {
        require(msg.sender == user_B, "You can't Submit Work");
        workDone = true;
    }

    function verifyAndPay () public {
        require(msg.sender == user_A, "Not Authorized to Verify and Pay !!");
        require(isPayed == false, "Already Paid");
        require(address(this).balance == contractAmount, "Insufficient Funds !!");
        require(workDone == true, "Work is Incomplete");
        
        user_B.transfer(contractAmount);
        isPayed = true;
    }


}
