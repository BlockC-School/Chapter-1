const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AccessControl", function () {
  it("Should return the new greeting once it's changed", async function () {
    const AccessControl = await ethers.getContractFactory("AccessControl");
    const access = await AccessControl.deploy(33, 0x657E368438B2cF77aD214A3A7ff4A6b821A11a64);
    await access.deployed();

    expect(await access.getPrice()).to.equal(33);

    const setValue = await access.setPrice(333);

    // wait until the transaction is mined
    await setValue.wait();

    expect(await access.getPrice()).to.equal(333);
  });
});
