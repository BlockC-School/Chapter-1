const { assert } = require("chai");

const Multisig = artifacts.require('Multi_sig');
contract("Multisig", async (accounts) => {
    let wallet;
    beforeEach(async () => {
      wallet = await Multisig.new();
      web3.eth.sendTransaction({
        from: accounts[0],
        to: wallet.address,
        value: 10 ** 18,
      });
    });
    // get balance of wallet
    it("should add owners", async () => {
      console.log(wallet);
      const addOwner = wallet.addOwner();
      // console.log(wallet);
      assert.equal(addOwner);
    });
    
  });