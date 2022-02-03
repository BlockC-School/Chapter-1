// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
let employee ;
async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Employee = await hre.ethers.getContractFactory("EmployeeDetails");
   employee = await Employee.deploy();

  await employee.deployed();

  console.log("employee deployed to:", employee.address);
  //console.log("employee", employee);
 //console.log("EmpID",  await employee.AddEmployee("sunil", "sunil@gmail", 23, "0xCFcE525617ABe3e889f7A95623082a7DD2e50A0E"));
  //  console.log(await employee.GetEmployee(1));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
