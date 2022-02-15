const LoanStateMachine = artifacts.require("LoanStateMachine");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("Loan State Machine Testings", async (accounts) => {
  let loanStateMachine;
  beforeEach(async () => {
    loanStateMachine = await LoanStateMachine.new(
      10 ** 6,
      10,
      10,
      accounts[1],
      accounts[0],
    );
  });

  /******************************************************************
                  Should NOT accept fund if not lender
   ****************************************************************/
  it("Should NOT accept fund if not lender", async () => {
    await expectRevert(
      loanStateMachine.fund(accounts[1], { from: accounts[1] }),
      "You are not a Lender",
    );
  });

  /******************************************************************
                  Should NOT accept fund if not lender (using try & catch block)
   ****************************************************************/
  it("Should NOT accept fund if not lender (using try & catch block)", async () => {
    try {
      await loanStateMachine.fund(accounts[1], { from: accounts[1] });
    } catch (e) {
      assert(e.reason === "You are not a Lender");
    }
  });

  /******************************************************************
                  Should NOT accept fund if not exact amount
   ****************************************************************/
  it("Should NOT accept fund if not exact amount", async () => {
    await expectRevert(
      loanStateMachine.fund(accounts[1], { from: accounts[0], value: 10 ** 5 }),
      "Please Provide the accurate Amount",
    );
  });

  /******************************************************************
                  Should NOT accept fund if not exact borrower
   ****************************************************************/
  it("Should NOT accept fund if not exact borrower", async () => {
    await expectRevert(
      loanStateMachine.fund(accounts[3], { from: accounts[0], value: 10 ** 6 }),
      "Please Pass one authenticate Borrower",
    );
  });

  /******************************************************************
                  Should accept fund
   ****************************************************************/
  it("Should accept fund", async () => {
    const response = await loanStateMachine.fund(accounts[1], {
      from: accounts[0],
      value: 10 ** 6,
    });
    assert(response.receipt.status);
  });

  /******************************************************************
                  Should NOT reimburse if not lender
   ****************************************************************/
  it("Should NOT reimburse if not lender", async () => {
    await loanStateMachine.fund(accounts[1], {
      from: accounts[0],
      value: 10 ** 6,
    });
    await expectRevert(
      loanStateMachine.rembuirse(12, accounts[2], {
        from: accounts[1],
        value: 10 ** 6,
      }),
      "Your Provided account is not your Lender",
    );
  });

  /******************************************************************
                  Should NOT reimburse if not exact amount
   ****************************************************************/
  it("Should NOT reimburse if not exact amount", async () => {
    await loanStateMachine.fund(accounts[1], {
      from: accounts[0],
      value: 10 ** 6,
    });
    await expectRevert(
      loanStateMachine.rembuirse(12, accounts[0], {
        from: accounts[1],
        value: 10 ** 6,
      }),
      "Amount Should be Principle + Interest all together",
    );
  });

  /******************************************************************
                  Should NOT reimburse if loan hasnt matured yet
   ****************************************************************/
  it("Should NOT reimburse if loan hasnt matured yet", async () => {
    await loanStateMachine.fund(accounts[1], {
      from: accounts[0],
      value: 10 ** 6,
    });
    await expectRevert(
      loanStateMachine.rembuirse(9, accounts[0], {
        from: accounts[1],
        value: 10 ** 6,
      }),
      "Your End date have not been crossed",
    );
  });

  /******************************************************************
                  Should reimburse
   ****************************************************************/
  it("Should reimburse", async () => {
    const totalReturnableAmount =
      await loanStateMachine.getTotalReturnableAmount(11);

    await loanStateMachine.fund(accounts[1], {
      from: accounts[0],
      value: 10 ** 6,
    });

    const response = await loanStateMachine.rembuirse(11, accounts[0], {
      from: accounts[1],
      value: totalReturnableAmount,
    });

    assert(response.receipt.status);
  });
});
