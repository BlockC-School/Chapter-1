const { expect } = require("chai");
const { ethers } = require("ethers");
// const { ethers } = require("hardhat");
// const { Timestamp } = require("mongodb");
// const CampaignFactory = require('./Campaign.json');
const OpenFunds = require('../artifacts/contracts/OpenFund.sol/OpenFunds.json');


// beforeEach( async () => {`
//   OpenFund = await ethers.getContractFactory(OpenFunds)
//   contract = await OpenFund.deployed()
// })`

describe("Crowd funding Campaign ", () => { 

  it("Should set the Fund once it's deployed", async function () {
    const OpenFund = await hre.ethers.getContractFactory("OpenFunds");
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    const campaign = await OpenFund.deploy( fundgol , 0);
    await campaign.deployed();

    console.log('mined at ', campaign.address);
                            // 0x5FbDB2315678afecb367f032d93F642f64180aa3
  });
});


describe('Open Fund', function() {

  before(async function() {
    this.OpenFund = await hre.ethers.getContractFactory('OpenFunds');
  });
// 
  beforeEach(async function() {
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    this.OpenFund = await this.OpenFund.deploy(fundgol, 0);
    await this.OpenFund.deployed();
  })


  it('Should create campaign', async function() {
    const Camp = await hre.ethers.getContractFactory('OpenFunds');
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    await this.OpenFund.CreateProject(1,'dodo','gogo',fundgol);
    const createCamp = await this.OpenFund.deployed();

    console.log('Project is created', createCamp.address);
  })
  

})

