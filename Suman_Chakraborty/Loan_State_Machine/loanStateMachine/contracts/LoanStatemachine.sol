// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract LoanStateMachine {
    enum LoanState {
        NORMAL,
        ACTIVE,
        CLOSED
    }

    LoanState public loanState = LoanState.NORMAL;

    uint public amount;
    uint public interest;
    uint public endDate;

    address payable private borrower;
    address payable private lender;

    constructor (uint _amount, uint _interest, uint _endDate, address payable _borrower, address payable _lender) public {
        amount = _amount;
        interest = _interest;
        endDate = _endDate;
        borrower = _borrower;
        lender = _lender;
	  }

    function transition(uint _payload) private returns (LoanState){
        if(_payload == 2){
            loanState = LoanState.CLOSED;
        }
        else if(_payload == 1){
            loanState = LoanState.ACTIVE;
        }
        else{
            loanState = LoanState.NORMAL;
        }

        return loanState;
    } 

    function  fund (address payable _borrower) external payable returns (LoanState){
        require(msg.sender == lender, "You are not a Lender");
        require(amount == msg.value, "Please Provide the accurate Amount");
        require(_borrower == borrower, "Please Pass one authenticate Borrower");

        (bool sent, bytes memory data) = _borrower.call{value: msg.value}("");
        require(sent, "Failed to send Ether to the Borrower");

        if(sent){
            LoanState response = transition(1);
            return response;
        }
        else{
            LoanState response = transition(0);
            return response;
        }
    }

    function rembuirse (uint _recentDate, address payable _lender ) external payable returns (LoanState) {
        
        require(msg.sender == borrower, "You are not the borrower");
        require(loanState == LoanState.ACTIVE, "You have not taken any loan");
        require(_lender == lender, "Your Provided account is not your Lender");
        require(_recentDate >= endDate, "Your End date have not been crossed");
        require(msg.value == getTotalReturnableAmount(_recentDate), "Amount Should be Principle + Interest all together");


        (bool sent, bytes memory data) = _lender.call{value: msg.value}("");
        require(sent, "Failed to send Ether to the Lender");
       
        if(sent){
            LoanState response = transition(2);
            return response;
        }
        else{
            LoanState response = transition(1);
            return response;
        }
    }


    function getTotalReturnableAmount(uint _recentDate) public view returns(uint){
        uint originalDuration = endDate;

        if(_recentDate > endDate){
            originalDuration = _recentDate;
        }

        uint interestAmount = (amount * interest * originalDuration)/100;
        uint amt = amount + interestAmount;
        return amt;
    }
    
}
