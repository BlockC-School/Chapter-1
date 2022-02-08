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
    it("should add owners", async () => {
      // console.log(wallet);
      const addowner = await wallet.addOwner(accounts[1], 2);
      // console.log(addowner); 
      // console.log(wallet);
      // assert.equal(addowner);
    });
    it('should deposit funds', async () => {
      // const deposit = await wallet.deposit(10 ** 18);
      const deposit = await wallet.deposit(web3.utils.toWei('0.1', 'ether'));
      // covert the deposit amount to small number
      assert.equal(deposit.logs[0].args.owner, accounts[0]);
      // console.log(deposit);
      // deposit is not working as expected

    })
  });