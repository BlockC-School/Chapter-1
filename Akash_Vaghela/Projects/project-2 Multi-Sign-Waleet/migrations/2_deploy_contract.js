const Multisig = artifacts.require('Multi_sig');

module.exports = async function(deployer, _network, accounts) {
	await deployer.deploy(Multisig);
	const wallet = await Multisig.deployed();
}