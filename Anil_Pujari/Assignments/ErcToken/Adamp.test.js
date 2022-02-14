
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe ("ADP Token",  function () {
  let wallet, owner, addr1, addr2;
  let totalSupply= 100000;
  beforeEach(async () => {
     [owner, addr1, addr2] = await ethers.getSigners();
    const ADP = await ethers.getContractFactory("Adamp");
     wallet = await ADP.deploy(totalSupply);
    await wallet.deployed();
  });

    it("Should have correct total supply", async function () {
    const totalSupply = await wallet.totalSupply();
    expect(totalSupply).to.equal(totalSupply);
    })

    it("Should have correct balance of owner", async function () {
    const balance = await wallet.balanceOf(owner.address);
    let expectedBalance = totalSupply*10**18;
    expectedBalance = expectedBalance.toString();
    expect(balance).to.equal("100000000000000000000000");
    });
    
    it("Should have correct allowance of spender", async function(){
    const spender = addr1.address;
    const amount = 1**18;
    await wallet.approve(spender, amount);
    const allowance = await wallet.allowance(owner.address, spender);
    expect(allowance).to.equal(amount);
    })

    it("Should transfer from owner to spender", async function(){
    const spender = addr1.address;
    const amount = 1**18;
    await wallet.transfer(spender, amount);
    const balance = await wallet.balanceOf(spender);
    expect(balance).to.equal(amount);
    });

    it("Should tranfer amount from spender to other", async function (){
        const spender = addr1.address;
    const amount = 1**18;
    await wallet.approve(spender, amount);
     await wallet.connect(addr1).transferFrom(owner.address, addr2.address, amount);
    const balance = await wallet.balanceOf(addr2.address);
    const ownerBalance = await wallet.balanceOf(owner.address);
    expect(balance).to.equal(amount);
    expect(Number(ownerBalance)).to.equal(Number(totalSupply*10**18)-amount);
    })

});