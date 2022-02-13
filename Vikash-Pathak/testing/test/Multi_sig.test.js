const { assert } = require("chai");

const Multisig = artifacts.require('Multi_sig');
contract("Multisig", async (accounts) => {
    let wallet;
    beforeEach(async () => {
      wallet = Multisig.new();
      web3.eth.sendTransaction({
        from: accounts[0],
        to: wallet.address,
        value: 10 ** 18,
      });
    });
    // get balance of wallet
    it("should return the correct balance", async () => {
      const getbalance = await wallet.getbalance();
      assert.equal(getbalance.toNumber(), 10 ** 18);
    });
    
  });