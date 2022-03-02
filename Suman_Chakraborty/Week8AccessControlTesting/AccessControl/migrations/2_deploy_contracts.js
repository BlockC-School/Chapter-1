const Price = artifacts.require("Price");

module.exports = async (deployer, network, accounts) => {
  await deployer.deploy(Price, 100, { from: accounts[0] });
  await Price.deployed();
  console.log("Price Contract Deployed Succesfully...");
};
