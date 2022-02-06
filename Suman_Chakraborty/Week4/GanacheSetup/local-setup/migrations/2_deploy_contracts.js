const MultiSignerWallet = artifacts.require("MultiSignerWallet");

module.exports = async (deployer, _network, accounts) => {
  await deployer.deploy(MultiSignerWallet, [
    accounts[0],
    accounts[1],
    accounts[2],
  ]);
  const wallet = await MultiSignerWallet.deployed();
  console.log(wallet);
};
