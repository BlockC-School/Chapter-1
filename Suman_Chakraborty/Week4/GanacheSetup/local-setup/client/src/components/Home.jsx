import React from "react";
import { ethers } from "ethers";
import Wallet from "../contracts/MultiSignerWallet.json";

export const Home = () => {
  const handleConnect = async () => {
    const provider = new ethers.providers.JsonRpcProvider(
      "HTTP://127.0.0.1:7545",
      5777,
    );

    console.log(await provider.getSigner(0));

    const wallet = new ethers.Contract(
      Wallet.networks["5777"].address,
      Wallet.abi,
      provider,
    );

    console.log(wallet);
  };

  React.useEffect(() => {
    handleConnect();
  }, []);
  return (
    <div>
      <h2>Multi Signer Wallet</h2>
    </div>
  );
};
