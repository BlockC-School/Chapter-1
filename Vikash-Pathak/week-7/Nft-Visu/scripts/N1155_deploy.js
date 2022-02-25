// Deploy Scipt for NFT-Vis projects contract
// instance of Hardhat
const hre = require('hardhat');
// 0x5FbDB2315678afecb367f032d93F642f64180aa3 addess where contract is deployed { 0x3DCa5D676e51E6E1102E438e7EE754736C073Ae6 }
// function to deploye the contract
async function main() {
  // Storing the Contract file In N15 constant 
    const N1155 = await hre.ethers.getContractFactory("Nft_vMint");
    const n15 = await N1155.deploy(  // Deployed instance in n15
        // Constructor input EX~ Name,SymBl,Uri
        "Amandeep-AVatar",
        "ARMA",
        "https://ipfs.io/ipfs/QmaSWuw7XMyVbQCj9KaKMJFfnTntZFgodBqXHboSQESgvJ/" // ------
    );
// wait until deployed
    await n15.deployed();
    console.log("Contract is deployed on this address~;", n15.address)

    // mint the collections 
    await n15.mint(1);
    await n15.mint(6);
    await n15.mint(3);
    await n15.mint(3);
    await n15.mint(3);
    await n15.mint(6);
    await n15.mint(1);

    console.log("nfts Are minted ")
}
// Fallback function
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
