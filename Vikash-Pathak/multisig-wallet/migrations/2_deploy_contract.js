const Multi_sig = artifacts.require('Multi_sig');


module.exports = async function(deployer, _network, _accounts) {
	await deployer.deploy(Multi_sig);
	const wallet = await Multi_sig.deployed();
}