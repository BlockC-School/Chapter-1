const { assert } = require("chai");

const Multisig = artifacts.require('Token');
contract("Token", async (accounts) => {
    let wallet;
    beforeEach(async () => {
      wallet = Multisig.new();
      web3.eth.sendTransaction({
        from: accounts[0],
        to: wallet.address,
        value: 10 ** 18,
      });
    });

})