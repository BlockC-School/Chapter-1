const { assert } = require("console");

const MultiSignerWallet = artifacts.require("MultiSignerWallet");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("MultiSignerWallet Testing", async (accounts) => {
  let wallet;

  // beforeEach(async () => {
  //   wallet = await MultiSignerWallet.new([
  //     accounts[0],
  //     accounts[1],
  //     accounts[2],
  //   ]);
  //   // web3.eth.sendTransaction({
  //   //   to: wallet.address,
  //   //   from: accounts[0],
  //   //   value: 10 ** 18,
  //   // });
  // });

  // console.log(wallet);

  it("New Wallet Address is Creating", async () => {
    wallet = await MultiSignerWallet.new([
      accounts[0],
      accounts[1],
      accounts[2],
    ]);
  });

  // Constructor Checking
  it("Constructor works Properly", async () => {
    const owners = await wallet.getOwners({ from: accounts[0] });
    assert(
      owners[0] === accounts[0] &&
        owners[1] === accounts[1] &&
        owners[2] === accounts[2],
    );
    // assert.equal(owners.length, 3);
  });

  // assignOwner Checking
  it("Assign Owner Function will not work if you are not an owner", () => {
    expectRevert(
      wallet.assignOwner(accounts[3], { from: accounts[4] }),
      "You are not the Owner",
    );
  });
  it("Assign Owner Function will not work if new owner is already an owner", () => {
    expectRevert(
      wallet.assignOwner(accounts[1], { from: accounts[0] }),
      "New Owner is Already an Owner",
    );
  });
  it("Assign Owner Function will work if you are an owner", async () => {
    await wallet.assignOwner(accounts[3], { from: accounts[0] });
    const owners = await wallet.getOwners({ from: accounts[0] });
    // console.log(owners);
    assert(owners[owners.length - 1] === accounts[3]);
  });

  //Get Owner Checking
  it("Get Owner Function will not work if you are not an owner", () => {
    expectRevert(
      wallet.getOwners({ from: accounts[4] }), //accounts[3] is not an owner
      "You are not the Owner",
    );
  });
  it("Get Owner Function will work if you are an owner", async () => {
    const owners = await wallet.getOwners({ from: accounts[0] });
    assert(owners.length === 4);
  });

  //createTransaction() checking
  it("Create Transaction Function will not work if you are not an owner", () => {
    expectRevert(
      wallet.createTransaction(accounts[3], 10 ** 18, { from: accounts[4] }),
      "You are not the Owner",
    );
  });
  it("Create Transaction Function will work if you are an owner", async () => {
    const tx = await wallet.createTransaction(accounts[3], 10 ** 18, {
      from: accounts[0],
    });
    console.log("Consoling the Transaction", tx);
    // assert(tx === 0);
  });
});
