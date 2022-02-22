const MyERC721 = artifacts.require('MyERC721');

module.exports = async function(deployer, _network, accounts) {
	await deployer.deploy(MyERC721, "NARUTO COLLECTION", "NUBM");
	const wallet = await Multisig.deployed();
    console.log("wallet is => ", wallet)
}