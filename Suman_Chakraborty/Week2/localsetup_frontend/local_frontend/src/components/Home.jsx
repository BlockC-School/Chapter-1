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

  const [wallet, setWallet] = useState(null);
  const [displayButton, setDisplayButton] = useState("Add Employee");

  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

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

  const handleAddEmployee = async () => {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(
        contractAddress,
        EmployeeDictionaryAbi.abi,
        signer,
      );

      try {
        const response = await contract.getAllEmployees();
        console.log(response);
      } catch (e) {
        console.log("Error", e);
      }
    }
  };

  useEffect(() => connectAccounts(), []);

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
    </div>
  );
};
