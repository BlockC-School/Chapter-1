const MultiSignWallet = artifacts.require("MultiSignWallet");


contract("MultiSigner Wallet" , async (accounts) => {
    let wallet;
    beforeEach(async () => {
        wallet = await MultiSignWallet.new()
        
        web3.eth.sendTransaction({
            to: wallet.address,
            from: accounts[0],
            value: 10 ** 18
        })
    })
})