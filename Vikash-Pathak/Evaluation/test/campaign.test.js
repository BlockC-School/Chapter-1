// import './Campaign.json'
const { Contract, ethers } = require("ethers");
const Campaign_test = require("./Campaign.json");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
describe("Campaign" , async accounts => {
  it('Should deploy the contract', async () => {
    const campaign_test = await ethers.getContractFactory(Campaign_test);
    const Camp = await campaign_test.deploy(1);
  })
});