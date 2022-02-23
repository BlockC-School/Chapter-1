const MyERC721 = artifacts.require('MyERC721');

module.exports = async function(deployer, _network, accounts) {
	await deployer.deploy(MyERC721, "NARUTO COLLECTION", "NUBM");
	const wallet = await MyERC721.deployed();
    // calling mint function
    const tokenId = await wallet.mint("https://gateway.pinata.cloud/ipfs/QmSMGehLU8r8XWhpnfMzviEnwkS6xomrNZtNgGmS55PnjS");
    console.log("Token Id after mint => ", tokenId)
}