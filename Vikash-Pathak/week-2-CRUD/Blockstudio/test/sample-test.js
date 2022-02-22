import { expect } from "chai";
import { ethers } from "hardhat";

describe("Employ", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Employ = await ethers.getContractFactory("Employe");
    const employee = await Employ.deploy("Hello, world!");
    await employee.deployed();

    expect(await employee.greet()).to.equal("Hello, world!");

    const setGreetingTx = await employee.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await employee.greet()).to.equal("Hola, mundo!");
  });
});
