const hre = require("hardhat");
const coingecko = require("coingecko-api");

async function main() {
  // We get the contract to deploy
  const [admin, reporter] = await hre.ethers.getSigners();
  const Oracle = await hre.ethers.getContractFactory("Oracle");
  const oracle = await Oracle.deploy(admin.address);

  await oracle.deployed();

  //   console.log("Oracle deployed to:", oracle.address);

  const Interval = 5000;
  const coinGeckoClint = new coingecko();

  while (true) {
    const response = await coinGeckoClint.coins.fetch("bitcoin", {});
    let currentPrice = response.data.market_data.current_price.inr;

    await oracle.connect(admin).UpdateReporter(reporter.address, true);

    await oracle
      .connect(reporter)
      .UpdateData(
        hre.ethers.utils.keccak256(hre.ethers.utils.toUtf8Bytes("BTC/USD")),
        currentPrice
      );

    console.log("currentPrice:", currentPrice);

    const data = await oracle.getData(
      hre.ethers.utils.keccak256(hre.ethers.utils.toUtf8Bytes("BTC/USD"))
    );

    console.log(data);

    await new Promise((resolve, _) => setTimeout(resolve, Interval));
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
