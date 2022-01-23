import React, { useEffect, useState } from "react";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import { ethers, BigNumber } from "ethers";
import EmployeeDictionaryAbi from "../EmployeeDictionaryAbi.json";

const initState = {
  name: "",
  email: "",
  age: "",
  walletAddress: "",
};

export const Home = () => {
  const [empDetails, setEmpDetails] = useState(initState);
  const [empId, setEmpId] = useState("");
  const [delteEmpId, setDeleteEmpId] = useState("");

  const [wallet, setWallet] = useState(null);
  const [contract, setContract] = useState({});
  const [displayButton, setDisplayButton] = useState("Add Employee");

  const contractAddress = "0xe655c414D991aFD6E6779b59B15cf87bd5F922D5";
  // const provider = new ethers.getDefaultProvider(4);
  // const signer = provider.getSigner();

  const { name, email, age, walletAddress } = empDetails;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setEmpDetails((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleSubmit = () => {
    console.log(empDetails);
    handleAddEmployee();
  };

  const connectAccounts = async () => {
    if (window.ethereum) {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log(accounts);

      setWallet(accounts[0]);
    } else {
      setDisplayButton("Please enable metamask");
      return;
    }
  };

  const connectContract = () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(
      contractAddress,
      EmployeeDictionaryAbi.abi,
      signer,
    );
    setContract(contract);
    // return contract;
    // console.log(contract.addEmployee);
  };

  const handleAddEmployee = async () => {
    // if (window.ethereum) {
    //   const provider = new ethers.providers.Web3Provider(window.ethereum);
    //   const signer = provider.getSigner();
    //   const contract = new ethers.Contract(
    //     contractAddress,
    //     EmployeeDictionaryAbi.abi,
    //     signer,
    //   );

    //   try {
    //     const response = await contract.getAllEmployees();
    //     console.log(response);
    //   } catch (e) {
    //     console.log("Error", e);
    //   }
    // }

    const { name, email, age, walletAddress } = empDetails;
    const { addEmployee } = contract;
    const res = await addEmployee(name, email, age, walletAddress);
    console.log(res);

    const decodedRes = await ethers.utils.defaultAbiCoder.decode(
      ["uint256"],
      ethers.utils.hexDataSlice(res.data, 1),
    );
    console.log("Returning from Add Employees,", decodedRes[0]);

    console.log(
      "Returning from Add Employees, toString : ",
      decodedRes[0].toString(),
    );
    // console.log(
    //   "Returning from Add Employees, toNumber : ",
    //   decodedRes.toFixed(),
    // );
  };

  const handleGetAllEmployees = async () => {
    console.log("Hoo");
    const { getAllEmployees } = contract;
    const res = await getAllEmployees();
    console.log("Returning from Get All Employees: ", res);
  };

  const handleGetEmployee = async () => {
    const { getEmployee } = contract;
    const res = await getEmployee(empId);
    console.log("Returning from Get Employee: ", res);
  };

  const handleDeleteEmployee = () => {
    const { deleteEmployee } = contract;
    console.log("Hiii");
    deleteEmployee(BigNumber.from(empId)).then((res) => {
      handleGetAllEmployees();
    });
  };

  useEffect(() => connectContract(), []);

  return (
    <div>
      <br />
      <br />
      <h1>Employee Collection</h1>

      <TextField
        label="Name"
        type="text"
        name="name"
        onChange={handleChange}
        value={name}
      />
      <br />
      <br />
      <TextField
        label="Email"
        type="email"
        name="email"
        onChange={handleChange}
        value={email}
      />
      <br />
      <br />
      <TextField
        label="Age"
        type="number"
        name="age"
        onChange={handleChange}
        value={age}
      />
      <br />
      <br />
      <TextField
        label="Wallet Address"
        type="text"
        name="walletAddress"
        onChange={handleChange}
        value={walletAddress}
      />
      <br />
      <br />
      <Button variant="contained" onClick={handleSubmit}>
        {displayButton}
      </Button>
      <br />
      <br />
      <Button variant="contained" onClick={handleGetAllEmployees}>
        Get All Employee
      </Button>
      <br />
      <br />
      <br />
      <br />
      <TextField
        label="Employee Id"
        type="text"
        name="empId"
        onChange={(e) => setEmpId(e.target.value)}
        value={empId}
      />
      <br />
      <br />
      <Button variant="contained" onClick={handleGetEmployee}>
        Get the Employee
      </Button>

      <br />
      <br />
      <br />
      <br />
      {/* <TextField
        label="Employee Id"
        type="text"
        name="empId"
        onChange={(e) => setDeleteEmpId(e.target.value)}
        value={delteEmpId}
      />
      <br />
      <br />
      <Button variant="contained" onClick={handleDeleteEmployee}>
        Delete the Employee
      </Button> */}
    </div>
  );
};
