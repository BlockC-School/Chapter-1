import React from "react";
import { ethers } from "ethers";
import Wallet from "../contracts/MultiSignerWallet.json";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";

export const Home = () => {
  const [newAddress, setNewAddress] = React.useState("");
  let provider, wallet, signer;

  const handleConnect = async () => {
    provider = new ethers.providers.JsonRpcProvider(
      "HTTP://127.0.0.1:7545",
      5777,
    );

    signer = await provider.getSigner();

    console.log(signer);

    wallet = new ethers.Contract(
      Wallet.networks["5777"].address,
      Wallet.abi,
      provider,
    );

    console.log(wallet);
  };

  const handleAddNewOwner = async () => {
    console.log(await wallet.assignOwner(newAddress));
  };

  React.useEffect(() => {
    handleConnect();
  }, []);

  return (
    <div>
      <h2>Multi Signer Wallet</h2>
      <TextField
        label="New Owner"
        variant="outlined"
        onChange={(e) => setNewAddress(e.target.value)}
      />
      <br />
      <Button variant="contained" onClick={handleAddNewOwner}>
        Add
      </Button>
    </div>
  );
};
