const { expect } = require("chai");
const { expectRevert } = require("@openzeppelin/test-helpers");

const LoanContract = artifacts.require("LoanContract");

contract(" Testing Loan Contract ", (accounts) => {
    let wallet;
    //constructor args: _lender, _borrower, _duration, _rateOfInterest, _amount
    LoanContract.defaults({
        from: accounts[0],
        gas: 4712388,
        gasPrice: 100000000000
      })
    it("Passing constructor with _lender as a address(0) expect error", async () => {
        try{
            wallet = await LoanContract.new("0x0000000000000000000000000000000000000000", accounts[1], 1, 1, 1 );
        }catch(error){
            expect(error.reason).to.be.equal("InvalidLender");
        }
    })

    it("Passing constructor with _borrower as a address(0) expect error", async () => {
        try{
            wallet = await LoanContract.new(accounts[0], "0x0000000000000000000000000000000000000000", 1, 1, 1 );
        }catch(error){
            expect(error.reason).to.be.equal("InvalidBorrower");
        }
    })

    it("Passing constructor with _duartion as a 0 expect error", async () => {
        try{
            wallet = await LoanContract.new(accounts[0], accounts[1], 0, 1, 1 );
        }catch(error){
            expect(error.reason).to.be.equal("DurationMustBeGreaterThanZero");
        }
    })

    it("Passing constructor with _rateOfInterest as a 0 expect error", async () => {
        try{
            wallet = await LoanContract.new(accounts[0], accounts[1], 1, 0, 1 );
        }catch(error){
            expect(error.reason).to.be.equal("RateofInterestMustBeLess10AndGreaterThan0");
        }
    })

    it("Passing constructor with _rateOfInterest as a 11 expect error", async () => {
        try{
            wallet = await LoanContract.new(accounts[0], accounts[1], 1, 11, 1 );
        }catch(error){
            expect(error.reason).to.be.equal("RateofInterestMustBeLess10AndGreaterThan0");
        }
    })

    it("Passing constructor with _amount as a 0 expect error", async () => {
        try{
            wallet = await LoanContract.new(accounts[0], accounts[1], 1, 1, 0 );
        }catch(error){
            expect(error.reason).to.be.equal("AmountShouldBeGreaterThanZero");
        }
    })

    it("Passing constructor with all correct values", async () => {
        try{
            wallet = await LoanContract.new(accounts[0], accounts[1], 1, 1, 1 );
        }catch(error){
            expect(error.reason).to.be.equal("AmountShouldBeGreaterThanZero");
        }
    })

    it("Calling fund function with wrong lender", async () => {
        try{
           await wallet.fund({from: accounts[1]});
        }catch(error){
            expect(error.reason).to.be.equal("OnlyLenderCallThis");
        }
    })

    it("Calling fund function with correct lender but we get error, because of insufficent fund", async () => {
        try{
           await wallet.fund({from: accounts[0]});
        }catch(error){
            expect(error.reason).to.be.equal("InsufficientFundInContract");
        }
    })

    it("Calling fund function with all correct value ", async () => {
        try{
           await wallet.fund({from: accounts[0], value: 2});
        }catch(error){
            console.log(error);
        }
    })

    it("Calling getBalance function ", async () => {
        try{
           const balance = await wallet.getBalance();
           const {words} = balance
           expect(words[0]).to.be.equal(1)
        }catch(error){
            console.log(error);
        }
    })

    it("Calling calculateInterstMoney function ", async () => {
        try{
           const interest = await wallet.calculateInterstMoney();
           const {words} = interest
           expect(words[0]).to.be.equal(0)
        }catch(error){
            console.log(error);
        }
    })

    it("Calling rembuirse with wrong borrower ", async () => {
        try{
           await wallet.rembuirse({from: accounts[0]});
        }catch(error){
            expect(error.reason).to.be.equal("OnlyBorrowerCallThis");
        }
    })

    it("Calling rembuirse, but duration is not completed ", async () => {
        try{
           await wallet.rembuirse({from: accounts[1], value: 3});
        }catch(error){
            expect(error.reason).to.be.equal("LoanDurationNotCompleted");
        }
    })

    it("Calling fund function with all correct value, but one loan is already in active, get error ", async () => {
        try{
           await wallet.fund({from: accounts[0], value: 2});
        }catch(error){
            console.log(error.reason);
            expect(error.reason).to.be.equal("ThereIsNoLoanIsInitiatedOrActiveLoanNotPaid");
        }
    })
    
})