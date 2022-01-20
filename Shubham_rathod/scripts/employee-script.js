// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat');

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Employee = await hre.ethers.getContractFactory('Employee');
  const employee = await Employee.deploy();

  await employee.deployed();

  console.log('Greeter deployed to:', employee.address);
  const createdEmp = await employee.createEmployee({
    id: 1,
    name: 'shubham',
    email: 'shubs12@gmail.com',
    age: 26,
    wallet: 'helloda344',
  });

  //   setTimeout(() => {
  //     employee.createEmployee({
  //       name: 'Deepika',
  //       email: 'bigbooty@gmail.com',
  //       age: 31,
  //       wallet: 'warm',
  //     });
  //   }, 1000);

  const singleEmp = await employee.getEmployee(1);
  const update = await employee.updateEmployee(1, {
    id: 2,
    name: 'shubham',
    email: 'shubs12@gmail.com',
    age: 26,
    wallet: 'helloda344',
  });
  const Emp = await employee.getAllEmployee();

  const remove = await employee.deleteEmp(2);

  // console.log( await employee.getEmployee());
  // console.log(singleEmp);
  // console.log(update);
  // console.log(remove);
  console.log(Emp);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
