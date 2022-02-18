// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

// // custom error
//     error InvalidLender(address lender);
//     error InvalidBorrower(address borrower);
//     error DurationMustBeGreaterThanZero(uint duration);
//     error RateofInterestMustBeLess10(uint rateOfInterest);
//     error OnlyCallByLender();
//     error OnlyCallByBorrower();
//     error TransactionFailed();
//     error InsufficientFundInContract(uint amount, uint needAmount);
//     error LoanDurationNotCompleted(uint duration, uint current);
//     error ThereIsNoActiveLoan();
//     error ThereIsNoLoadIsInitiatedOrActiveLoanNotPaid();

contract LoanContract{

    enum State {
		PENDING,
		ACTIVE,
		CLOSED
	}
    State public state;
    address payable public lender;
    address payable public borrower;
    uint public duration; // now we are taking duration in mintues only.
    uint public rateOfInterest;
    uint public amount;
    uint public nowTime;
    uint public durationTimeStamp;

    constructor(address payable _lender, address payable _borrower, uint _duration, uint _rateOfInterest, uint _amount ){

        require(_lender != address(0), "InvalidLender");
        require(_borrower != address(0), "InvalidBorrower");
        require(_duration > 0, "DurationMustBeGreaterThanZero");
        require(_rateOfInterest <= 10 && _rateOfInterest > 0 , "RateofInterestMustBeLess10AndGreaterThan0");
        require(_amount > 0 , "AmountShouldBeGreaterThanZero");
        lender = _lender;
        borrower = _borrower;
        duration = _duration;
        rateOfInterest = _rateOfInterest;
        amount = _amount;
        state = State.PENDING;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function fund() external payable {
        require(msg.sender == lender, "OnlyLenderCallThis");
        require(state == State.PENDING, "ThereIsNoLoadIsInitiatedOrActiveLoanNotPaid");
        uint bal = getBalance();
        require(bal > amount, "InsufficientFundInContract");
        (bool sent, ) = borrower.call{value: amount}("");
        require(sent, "TransactionFailed");
        state = State.ACTIVE;
        durationTimeStamp = block.timestamp;
    }

    function calculateInterstMoney() public view returns(uint interestAmount) {
        interestAmount = (amount * rateOfInterest * (duration / 525600)) / (100 * 12) ; // 525600, are used to convert minutes to year
    }

    function rembuirse() external payable {
        require(msg.sender == borrower, "OnlyBorrowerCallThis");
        require(state == State.ACTIVE, "ThereIsNoActiveLoan");
        uint current = block.timestamp;
        nowTime = current - durationTimeStamp;// here we are subtracting time when user get fund, with current if it is greater then we rembuirse.
        require(nowTime >= duration, "LoanDurationNotCompleted");
        uint bal = getBalance();
        uint interestAmount = calculateInterstMoney();
        require(bal >= interestAmount, "InsufficientFundInContract");
        (bool sent, ) = lander.call{value: amount}("");
        require(sent, "TransactionFailed");
        state = State.CLOSED;
    }

}