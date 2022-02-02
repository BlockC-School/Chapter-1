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
  const EmployeeData = await hre.ethers.getContractFactory("EmployeeData");
  const employeedata = await EmployeeData.deploy();

  await employeedata.deployed();


  console.log("EmployeeData deployed to:", employeedata.address);


  // Add Employee
  employeedata.addEmployee("Akash", "test@mail.com", 23, "0x002030010230")
  
  // Get Employee
  console.log("Employee Added as : ", await employeedata.getEmployee(0));
  console.log("");
  
  // Update Employee
  employeedata.updateEmployee(0, "Martin", "random@mail.com", 15, "0x077777770230");
  console.log("Employee updated as : ", await employeedata.getEmployee(0));
  console.log("");
  
  // Delete Employee
  employeedata.deleteEmployee(0)
  console.log("Employee Deleted");
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
