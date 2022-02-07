const MultiSigner = artifacts.require('MultiSigner');

module.exports = async function(deployer, _network, accounts) {
	await deployer.deploy(MultiSigner, [accounts[0], accounts[1], accounts[2]], 2);
	const wallet = await MultiSigner.deployed();
}