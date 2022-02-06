import logo from "./logo.svg";
import "./App.css";
import React from "react";
import { ethers } from "ethers";
import Wallet from "./contracts/MultiSignerWallet.json";

function App() {
  React.useEffect(async () => {
    const provider = new ethers.providers.JsonRpcProvider(
      "HTTP://127.0.0.1:7545",
      5777,
    );

    console.log(provider);
    console.log(await provider.listAccounts());

    const wallet = new ethers.Contract(
      Wallet.networks["5777"].address,
      Wallet.abi,
      provider,
    );

    console.log(wallet);
  });

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
