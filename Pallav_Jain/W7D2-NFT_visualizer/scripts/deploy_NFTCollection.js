const {
    ethers
} = require("hardhat");

// 0xe6c4796C867Bb019C105EC6246D1c253202183b1

async function main() {
    const Marvel_Collection = await ethers.getContractFactory("MarvelCollection");
    const MarvelCollection = await Marvel_Collection.deploy(
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