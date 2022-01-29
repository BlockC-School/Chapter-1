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
  const EmployeeDatabase = await hre.ethers.getContractFactory("EmployeeDatabase");
  const edata = await EmployeeDatabase.deploy();

  await edata.deployed();


  console.log("Employee Data is deployed to:", edata.address);
  // Add Employee
  edata.addEmp("Shrayank", "hrshrayank77@gmail.com", 24, "0xe82c1dcb4Ea572cBcd83d6E28F933F7aea82cB27")
  
  // Get Employee
  console.log("Employee Added as : ", await edata.getEmp(0));
 
  //Update
  edata.updateEmp(0, "Dhruva", "dhruva@gmail.com", 25, "0xe82c1dcb4Ea572cBcd83d6E28F933F7aea82cB27");

  console.log("Employee updated as : ", await edata.getEmp(0));
  
  //Delete
  edata.deleteEmp(0)
  console.log("Employee Data is deleted");
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
