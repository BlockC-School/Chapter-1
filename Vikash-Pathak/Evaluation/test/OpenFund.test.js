const { expect } = require("chai");
const { expectRevert } = require("@openzeppelin/test-helpers");
const { ethers } = require("ethers");
// const { ethers } = require("hardhat");
// const { Timestamp } = require("mongodb");
// const CampaignFactory = require('./Campaign.json');
const OpenFunds = require('../artifacts/contracts/OpenFund.sol/OpenFunds.json');
const FundsContract = require('../contracts/OpenFund.sol');


// before( async () => {
//   OpenFund = await hre.ethers.getContractFactory('OpenFunds')
//   contract = await OpenFunds.deployed()
// })

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
// created on 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
  beforeEach(async function() {
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    this.OpenFund = await this.OpenFund.deploy(fundgol, 0);
    await this.OpenFund.deployed();
  })


  it('Should create campaign', async function() {
    // const Camp = await hre.ethers.getContractFactory('OpenFunds');
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    await this.OpenFund.CreateProject(1,'dodo','gogo',fundgol);
    const createCamp = await this.OpenFund.deployed();

    console.log('Project is created', createCamp.address);
  })
// Working
})


describe('Should fund the project', async function() {
//   // const OpenFund = await hre.ethers.getContractFactory('OpenFunds');
//   // it('')
//   before( async function() {
//     this.OpenFund = await hre.ethers.getContractFactory('OpenFunds');
//   })
//   beforeEach(async function() {
//     const fundgol =  ethers.utils.parseUnits('0.6', 18);
//     const OpenFund = await this.OpenFund.deploy(fundgol, 0);
//     const DepFund = await OpenFund.deployed();
//     console.log(`Deployed ${DepFund} & functions ${fundgol} `);
//   })
//   const DeployedFunding = await OpenFund.deployed();
const Id = 1;
  it('Should fund the project', async function() {
    // const OpenFunds = await hre.ethers.getContractFactory('OpenFunds');
    const fundgol =  ethers.utils.parseUnits('0.6', 18);
    expectRevert(
      OpenFunds.Fund(
        fundgol
      ), 'already changed');

    // const Fuunding = await OpenFund.deployed();
    // let fund = await Fuunding.ChangeState();
    // await this.OpenFund.fund(3);
    // console.log(`Deployed ${Fuunding} & functions ${fund} `);
    // const funding = await this.funding.deployed();
  //   await this.funding.Funding.FundProject(1);
    
  //   console.log('project is funded with => ', funding.fund)
  })
  
})


describe("Crowd funding Campaign ", () => { 

  it("Should set the State ", async function () {
    console.log('State =>  at ', SetState);
    // const OpenFund = await hre.ethers.getContractFactory("OpenFunds");
    // const fundgol =  ethers.utils.parseUnits('0.6', 18);
    // const campaign = await OpenFund.deploy( fundgol , 0);
    // await campaign.deployed();
    const SetState = await OpenFunds.FundsContract.ChangeState();

    console.log('State =>  at ', SetState);
     // 0x5FbDB2315678afecb367f032d93F642f64180aa3
  });
});