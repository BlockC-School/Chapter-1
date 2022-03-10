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

  });
});
