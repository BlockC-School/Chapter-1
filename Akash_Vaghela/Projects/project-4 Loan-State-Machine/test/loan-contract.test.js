const LoanContract = artifacts.require("LoanContract");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("Loan Contract Testing", async (accounts) => {
    let myLoanContract;
    let borrower = accounts[0]
    let lender = accounts[1]
    beforeEach(async () => {
        myLoanContract = await LoanContract.new(1000, 12, 10, borrower, lender);
    })

    it('Should NOT accept fund if not lender', async () => {
        await expectRevert(
            myLoanContract.fund({from: borrower}),
            "Not an Authorized Person !!"
        )
    });

    it('Should NOT accept fund if not exact amount', async () => {
        await expectRevert(
            myLoanContract.fund({from: lender}),
            "Should Add Exact Amount of Fund!!"
        )
    });

    it('Should accept fund', async () => {
        const fund = await myLoanContract.fund({from: lender, value: 1000})
    });

    it('Should NOT reimburse if not lender', async () => {
        setTimeout(async () => {
            await expectRevert(
                myLoanContract.rembuirse(accounts[2], {value: 1120}),
                "Lender Address is InCorrect!!"
            )
        }, 1500);
    });

    it('Should NOT reimburse if not exact amount', async () => {
        await expectRevert(
            myLoanContract.rembuirse(lender, {value: 1000}),
            "Not Exact Fund !!"
        )
    });

    it('Should NOT reimburse if loan hasnt matured yet', async () => {
        await expectRevert(
            myLoanContract.rembuirse(accounts[1], {value: 1120}),
            "Not Matured!!"
        )
    });
    
    it('Should reimburse', async () => {
        setTimeout(() => {
            myLoanContract.rembuirse(lender, {from: borrower, value: 1120});
        }, 15000);
    });
   
})