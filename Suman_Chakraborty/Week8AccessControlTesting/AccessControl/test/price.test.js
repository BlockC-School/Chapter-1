const { assert } = require("console");

const Price = artifacts.require("Price");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("AgreedPrice Contract is Testing", async (accounts) => {
  let instance;
  let deployer = accounts[0];
  let attacker = accounts[1];
  let user = accounts[2];

  it("Should set price at deployment", async () => {
    let _price = 100;
    instance = await Price.new(_price, { from: deployer });
    assert((await instance.price()).toNumber() === _price);
  });

  it("Should set the deployer account as the owner at deployment", async () => {
    assert((await instance.owner()) === deployer);
  });

  it("Should be possible for the owner to change price", async () => {
    let _price = 200;
    await instance.updatePrice(_price, { from: deployer });
    assert((await instance.price()).toNumber() === _price);
  });

  it("Should NOT be possible for other than the owner to change price", async () => {
    try {
      await instance.updatePrice(300, { from: attacker });
    } catch (e) {
      assert(e.reason === "Only owner can update price");
    }
  });

  it("Should be possible for the owner to transfer ownership", async () => {
    await instance.transferOwnerShip(attacker, { from: deployer });
    assert((await instance.owner()) === attacker);
  });

  it("Should not be possible for other than the owner to transfer ownership", async () => {
    try {
      await instance.transferOwnerShip(user, { from: deployer });
    } catch (e) {
      assert(e.reason === "Only owner can transfer the ownership");
    }
  });

  it("Should not be possible for other than the owner to transfer ownership using expectRevert", async () => {
    expectRevert(
      instance.transferOwnerShip(user, { from: deployer }),
      "Only owner can transfer the ownership",
    );
  });

  it("Should be possible for a new owner to call updatePrice", async () => {
    await instance.updatePrice(500, { from: attacker });
    assert((await instance.price()).toNumber() === 500);
  });
});
