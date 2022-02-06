const Multisig = artifacts.require("Multisig");

contract("Multisigner Wallet", async (accounts) => {
    let wallet;
    beforeEach(async () => {
        wallet = Multisig.new(accounts[0], accounts[1], accounts[2], 2);

        web3.eth.sendTransaction({
            to: wallet.address,
            from: accounts[0],
            value: 1 ** 18,
        });
    });
    console.log(wallet);
})