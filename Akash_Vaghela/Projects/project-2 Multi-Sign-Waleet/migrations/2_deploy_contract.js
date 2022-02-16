const MultiSignWallet = artifacts.require("MultiSignWallet");

module.exports = async function (deployer, _network, accounts){
    await deployer.deploy(MultiSignWallet);
    const wallet =  await MultiSignWallet.deployed()
}

try {
    let wallet2 = MultiSignWallet.getBalance()._network;
    let wallet3 = MultiSignWallet.showOwner()._network;

} catch (err) {
    console.log(err);
}