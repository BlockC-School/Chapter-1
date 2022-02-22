import React from "react";
import { ethers } from "ethers";
import TodoJson from "../contracts/Todo.json";

export const Home = () => {
  React.useEffect(async () => {
    // const provider = new ethers.providers.Web3Provider(window.ethereum);
    const provider = new ethers.providers.JsonRpcProvider(
      "http://localhost:7545",
    );
    const signer = provider.getSigner(0);
    const address = "0x9bAa006732571548ba7b22390Dd8eb9C8B68e2da";
    const privateKey =
      "7a0075f062f48d20b2d30d01d8336621dba0d338c82cf9ee61a4bb91e48374ef";
    const wallet = new ethers.Wallet(privateKey, provider);
    const abi = TodoJson.abi;
    const contract = new ethers.Contract(address, abi, signer);

    // contract.addTask("Milk").then((res) => console.log(res));
    contract.getAllTask().then((res) => console.log(res));
    // console.log(await provider.listAccounts());
    console.log(contract);
  }, []);

  return <div>Home</div>;
};
