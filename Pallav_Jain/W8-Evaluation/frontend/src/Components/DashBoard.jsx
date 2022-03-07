import { useState } from "react";
import factoryABI from "../Factory.json";
import fundABI from "../FundABI.json";
import { ethers } from "ethers";
import NavBar from "./NavBar";

function App() {
  const [Address, setAddress] = useState("");

  async function ConnectWallet() {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();
      console.log("signer:", await signer.getAddress());
      setAddress(await signer.getAddress());
    } else {
      alert("No ETH Browser Exension Detected");
    }
  }

  async function CreateFund() {
    // useEffect(() => {
    //   const _MarvelCollection = new ethers.Contract(
    //     process.env.NEXT_PUBLIC_ADDRESS,
    //     abi,
    //     EthersProvider
    //   );
  }

  return (
    <div className="App">
      <NavBar />
      <h1>Welcome to CroudFuncding Dashboard</h1>
      <button onClick={ConnectWallet}>Connect Your Wallet</button>
    </div>
  );
}

export default App;
