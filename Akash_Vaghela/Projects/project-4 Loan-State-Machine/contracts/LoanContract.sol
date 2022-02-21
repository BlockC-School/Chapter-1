//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.6;

contract LoanContract {

    enum State {
		PENDING,
		ACTIVE,
		CLOSED
	}

	State public state = State.PENDING;
	uint public amount;
	uint public interest;
	uint public end;
	address payable public borrower;
	address payable public lender;

	constructor(uint _amount, uint _interest, uint _duration, address payable _borrower, address payable _lender) public {
		amount = _amount;
		interest = _interest;
		end = _duration + block.timestamp;
		borrower = _borrower;
		lender = _lender;
	}

	function showState () public view returns(State) {
		return(state);
	}

	// fund the contract by lender and send fund to borrower
	function fund() public checkLender payable {
		require(address(this).balance == amount, "Should Add Exact Amount of Fund!!");
		require(state != State.CLOSED, "Loan is Closed Already!!");
		require(state != State.ACTIVE, "Loan is Already Funded!!");
		borrower.transfer(address(this).balance);
		state = State.ACTIVE;
	} 

	// Remburise the amount from the borrower with interest
	function rembuirse(address payable _lender) public checkReimbursementAmount(address(this).balance) checkMaturity payable {
		require(_lender == lender, "Lender Address is InCorrect!!");
		require(state != State.CLOSED, "Loan is Closed Already!!");
		require(state != State.PENDING, "Loan is still in Pending state!!");
		_lender.transfer(address(this).balance);
		state = State.CLOSED;
	} 

    modifier checkLender(){
        require(msg.sender == lender, "Not an Authorized Person !!");
        _;
    }

	modifier checkReimbursementAmount(uint _amount){
        require((((interest * amount) / 100) + amount) == (_amount), "Not Exact Fund !!");
        _;
    }

	modifier checkMaturity(){
        require(block.timestamp >= end, "Not Matured!!");
        _;
    }
}