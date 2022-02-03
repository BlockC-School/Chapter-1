const { assert } = require("console");

const MultiSignerWallet = artifacts.require("MultiSignerWallet");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("MultiSignerWallet", async (accounts) => {
  let wallet;

  beforeEach(async () => {
    wallet = await MultiSignerWallet.new([
      accounts[0],
      accounts[1],
      accounts[2],
    ]);
    web3.eth.sendTransaction({
      to: wallet.address,
      from: accounts[0],
      value: 10 ** 18,
    });
  });

  console.log(wallet);

  // Constructor Checking
  it("Constructor works Properly", async () => {
    const owners = await wallet.getOwners();
    assert(owners[0] === accounts[0]);
    // assert.equal(owners.length, 3);
  });

  // assignOwner Checking
  it("Assign Owner works Properly", async () => {
    expectRevert(
      await wallet.assignOwner(accounts[3], { from: accounts[0] }),
      "You can't assign owner, as you are not an owner",
    );
  });
});
