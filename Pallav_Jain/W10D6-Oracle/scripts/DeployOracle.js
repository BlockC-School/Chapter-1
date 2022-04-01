const hre = require("hardhat");

async function main() {
    // We get the contract to deploy
    const [admin, reporter] = await hre.ethers.getSigners();
    const Oracle = await hre.ethers.getContractFactory("Oracle");
    const oracle = await Oracle.deploy(admin.address);

    await oracle.deployed();

    console.log("Oracle deployed to:", oracle.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
