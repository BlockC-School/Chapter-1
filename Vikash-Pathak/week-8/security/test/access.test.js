// const AccessControl = artifacts.require("AccessControl");
const { expect } = require("chai");
const { ethers } = require("hardhat");
/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */

// Test Block
describe("AccessControl",  function() {
  let deployer, attacker, user;
  // Get Contract Json
  before(async function() {
    AccessControl = await ethers.getContractFactory('AccessControl');
  });
  // Deploye the contract
  before(async function() {
    access = await AccessControl.deploy(33);
    await access.deployed();
  });
  beforeEach(async function () {
    [deployer, attacker, user] = await ethers.getSigners();
    const AccessControl = await ethers.getContractFactory("AccessControl", deployer);
  });
  // Test Cases
    it("Should set price at deployment", async function () {
      const SetPrice = await access.updatePrice(33);
      await SetPrice.wait();
      console.log("Price is setTo : ", SetPrice.getPrice());

      expect(await access.getPrice().to.equal(33));
    });

    it("Should set the deployer account as the owner at deployment", async function () {
      const AccessControl = await ethers.getContractFactory("AccessControl");
			const deployer = await AccessControl.deploy(11,0x657E368438B2cF77aD214A3A7ff4A6b821A11a64);
      await deployer.deployed();
      // Setting address at deployement
      expect(await deployer.owner.address.to.equal("0x657E368438B2cF77aD214A3A7ff4A6b821A11a64"))
    });

    it("Should be possible for the owner to change price", async function () {
      const owner = await AccessControl.updatePrice(21);
      console.log("Owner Details =>  ", owner)
      expect(await owner.getPrice().to.equal(21));
    
    });

    it("Should NOT be possible for other than the owner to change price", async function () {
      
    });

    it("Should be possible for the owner to transfer ownership", async function () {
     
    });

    it("Should be possible for a new owner to call updatePrice", async function () {
     
    });

    it("Should not be possible for other than the owner to transfer ownership", async function () {
      
   
  });
});