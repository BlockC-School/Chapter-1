// import './Campaign.json'
const { Contract, ethers, providers } = require("ethers");
const campaign = require("../artifacts/contracts/Campaign.sol/CampaignFactory.json");
const { expect } = require("chai");
const CampaignFactory = require('../artifacts/contracts/Campaign.sol/CampaignFactory.json');
/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
describe("CampaignFactory" , async accounts => {
  let market ;
  let token ;
  before( async () => {
    this.CampaignFactory = await hre.ethers.getContractFactory('CampaignFactory');
  });

  beforeEach( async () => {
    [owner, deployer,attacker] = providers.getSigner();
    this.CampaignFactory = await this.CampaignFactory.deploy();
    await this.CampaignFactory.deployed();
  })

  it("Should set the Fund once it's deployed", async function () {
    // const Campaign = await hre.ethers.getContractFactory("CampaignFactory");
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    const tokenId = '8xe7f1725E7734CE288F8367e1Bb143E90bb3F0512';
    await this.CampaignFactory.launch(999, block.timestampm ,date);
    // const campaign = await Campaign.deploy(tokenId, fundgol, 0);
    // await campaign.deployed();

    console.log('mined at ', CampaignFactory.address);
  })
});