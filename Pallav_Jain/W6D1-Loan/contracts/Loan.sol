pragma solidity ^0.8.11;

contract LoanContract {
	enum State {
		PENDING,
		ACTIVE,
		CLOSED
	}

	State public state = State.PENDING;
	uint public amount;
	uint public interest;
	uint public endDate;
    address payable public lender;
	address payable public borrower;
	
	constructor(uint _amount, uint _interest, uint _endDate, address payable _lender, address payable _borrower) payable {
        amount = _amount;
        interest = _interest;
        endDate = _endDate;
        lender = _lender;
        borrower = _borrower;
	}

    function getBalanceOfLender() public view  returns (uint) {
        return address(this).balance;
    }

    function getBalanceOfBorrower() public view  returns (uint) {
        return address(borrower).balance;
    }

	function fund(uint _amt) public payable {
        state = State.ACTIVE;
        address payable user = borrower;
        user.transfer(_amt);
        amount -= _amt;
    } // fund the contract by lender and send fund to borrower

	function rembuirse(uint _recentDate, address payable _lender ) external payable {
        require(state == State.ACTIVE, "You have not taken any loan");
        require(_lender == lender, "Your Provided account is not your Lender");
        require(_recentDate >= endDate, "Your End date have not been crossed");

        address payable user = _lender;
        user.transfer(getTotalReturnableAmount(_recentDate));
        // amount -= _amt;
    } //Remburise the amount from the borrower with interest

	function _transition() internal {
        state = State.CLOSED;
    } // internal function to move the loan state from pending to active and en


    function getTotalReturnableAmount(uint _recentDate) public view returns(uint){
        require(state == State.ACTIVE, "You have't taken any loan");
        uint originalendDate = endDate;

        if(_recentDate >= endDate){
            originalendDate = _recentDate;
        }

        uint interestAmount = (address(borrower).balance * interest * originalendDate)/100;
        uint amt = address(borrower).balance + interestAmount;
        return amt;
    }
}