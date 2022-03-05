const { expect, use } = require("chai");
const { ethers } = require("hardhat");

describe("Access Control", () => {
  let agreedPrice, deployer, attacker, user;

  beforeEach(async function () {
    [deployer, attacker, user] = await ethers.getSigners();

    const AgreedPrice = await ethers.getContractFactory("AgreedPrice");
    agreedPrice = await AgreedPrice.deploy(100);
    await agreedPrice.deployed();
  });

  describe("AgreedPrice", () => {
    it("Should set price at deployment", async function () {
      const price = await agreedPrice.price();
      expect(price).to.equal(100);
    });

    it("Should set the deployer account as the owner at deployment", async function () {
      const owner = await agreedPrice.owner();
      expect(owner).to.equal(deployer.address);
    });

    it("Should be possible for the owner to change price", async function () {
      await agreedPrice.connect(deployer).updatePrice(200);
      const price = await agreedPrice.price();
      expect(price).to.equal(200);
    });

    it("Should NOT be possible for other than the owner to change price", async function () {
      try {
        await agreedPrice.updatePrice(300, { from: attacker.address });
      } catch (e) {
        expect(e.reason == "You are not an Owner");
      }
    });

    it("Should be possible for the owner to transfer ownership", async function () {
      await agreedPrice.transferOwnership(user.address, {
        from: deployer.address,
      });
      const owner = await agreedPrice.owner();
      expect(owner).to.equal(user.address);
    });

    it("Should be possible for a new owner to call updatePrice", async function () {
      await agreedPrice.transferOwnership(user.address);

      await agreedPrice.connect(user).updatePrice(500);
      const price = await agreedPrice.price();
      expect(price).to.equal(500);
    });

    it("Should not be possible for other than the owner to transfer ownership", async function () {
      try {
        await agreedPric.connect(attacker).transferOwnership(user.address);
      } catch (e) {
        expect(e.reason == "You are not an Owner");
      }
    });
  });
});
