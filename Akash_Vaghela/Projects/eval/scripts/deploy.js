const { ethers } = require("hardhat");

async function main() {
    const Ben10ItemCollection = await ethers.getContractFactory(
        "Ben10ItemCollection"   // Contract Name
    );

    // Create new instance 
    const Ben10Items = await Ben10ItemCollection.deploy(
        "Ben10ItemCollection",      // NFT collection name
        "Ben10IC",                  // NFT symbol
        "https://gateway.pinata.cloud/ipfs/Qmf9ED6EVH5MGpBdhzBoawivAs6RWwUZ7e3kgdcPjPoqQT"
    )

    await Ben10Items.deployed();
    console.log("Success, Contract Deployed: ", Ben10Items.address);

    await Ben10Items.mint(2);
    await Ben10Items.mint(1);
    await Ben10Items.mint(100);
    await Ben10Items.mint(20);
    await Ben10Items.mint(1);
    await Ben10Items.mint(10);
    await Ben10Items.mint(4);

    console.log("NFT minted");
}

main()
.then(() => {
    process.exit(0)
})
.catch((err) => {
    console.error(err);
    process.exit(1);
})