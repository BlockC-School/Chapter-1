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
  const EmployeeDictionary = await hre.ethers.getContractFactory(
    "EmployeeDictionary",
  );
  const employeeDictionary = await EmployeeDictionary.deploy();

  await employeeDictionary.deployed();

  // const add = await employeeDictionary.addEmployee(
  //   "Suman",
  //   "suman@gmail.com",
  //   23,
  //   "0x8a210cfc20504cae244a12eb6b6d39556e6a1e58",
  // );
  // console.log(add);

  console.log("Whole EmployeeDictionary is: ", employeeDictionary);
  console.log("EmployeeDictionary deployed to:", employeeDictionary.address);

  const accounts = await hre.ethers.getSigners();
  for (let account of accounts) {
    console.log(account.address);
  }
  // employeeDictionary.
  // console.log("Function1:", await greeter.greet());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
