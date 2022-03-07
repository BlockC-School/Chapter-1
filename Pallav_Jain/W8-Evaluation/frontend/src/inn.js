import Onboard from "bnc-onboard";
import Web3 from "web3";
import { useState } from "react";

const onboard = Onboard({
  dappId: "2c4e8ed1-edb5-4e80-aa52-217c5229c6ab", // [String] The API key created by step one above
  networkId: 4, // [Integer] The Ethereum network ID your Dapp uses.
  subscriptions: {
    wallet: (wallet) => {
      // eslint-disable-next-line no-unused-vars
      let web3 = new Web3(wallet.provider);
      console.log(`${wallet.name} is now connected`);
    },
  },
});

function App() {
  const [Address, setAddress] = useState("");

  async function Login() {
    await onboard.walletSelect();
    await onboard.walletCheck();
    const { address } = onboard.getState();
    setAddress(address);
    console.log("currentState:", address);
  }
  return (
    <div className="App">
      <h1>Welcome to CroudFuncding Dashboard</h1>
      <button onClick={Login}>Connect Your Wallet</button>
    </div>
  );
}

export default App;
