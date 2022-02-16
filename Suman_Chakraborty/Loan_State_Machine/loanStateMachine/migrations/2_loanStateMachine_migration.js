const LoanStateMachine = artifacts.require("LoanStateMachine");
module.exports = async (deployer, network, accounts) => {
  await deployer.deploy(
    LoanStateMachine,
    10 ** 6,
    10,
    10,
    accounts[1],
    accounts[0],
  );
  const loanStateMachine = await LoanStateMachine.deployed();
};
