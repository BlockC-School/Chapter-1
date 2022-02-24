const {
    ethers
} = require("hardhat");

// 0x2B814062F377bF85Dc3f18897Fb31e0ffEb47Eff

async function main() {
    const MarvelCollection = await ethers.getContractFactory("MarvelCollection");
    const MarvelCollection = await MarvelCollection.deploy(
        "Marvel_Collection",
        "MRVLC",
        "https://ipfs.io/ipfs/QmdxSssA8WAamxKFnmNExQnf8jZ5WM1UjyAoqZ5nRRcf4k/"
    );

    await MarvelCollection.deployed();
    console.log("Success! Contract was deployed to: ", MarvelCollection.address);

    await MarvelCollection.mint(5); //Black_Panther
    await MarvelCollection.mint(10); //Captian_Marvel
    await MarvelCollection.mint(1); //Captian_America
    await MarvelCollection.mint(8); //Ant_Man
    await MarvelCollection.mint(11); //Black_Widow
    await MarvelCollection.mint(19); //Dr._Strange
    await MarvelCollection.mint(21); //Thanos
    await MarvelCollection.mint(15); //Spider_Man
    await MarvelCollection.mint(102); //Thor
    await MarvelCollection.mint(3); //DeadPool

    console.log("NFT successfully minted");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });