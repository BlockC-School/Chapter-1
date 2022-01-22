// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Greeter = await hre.ethers.getContractFactory("Employee");
  const greeter = await Greeter.deploy();

  // await greeter.addEmployeeData('Rohan', 24, 'xyz.com', '0xeb4Ced65D86301E9E75478D4712dFb968DD1985b')
  // const data = await greeter.getAllEmployeeData()
  // await greeter.editEmployeeData(0, 'Ranjan', 25, 'xyza.com', '0xeb4Ced65D86301E9E75478D4712dFb968DD1985b' )
  // console.log('Before Edit Data is => ', data)
  // const newData = await greeter.getAllEmployeeData()
  // console.log('After Edit Data is => ', newData)
  // await greeter.deleteEmployeeData(0)
  // const deleteData = await greeter.getAllEmployeeData()
  // console.log('After Delete Data is => ', deleteData)


  // await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
