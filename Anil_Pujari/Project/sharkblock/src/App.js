import React, { useEffect, useState } from "react";
import { useMoralis } from "react-moralis";
import "./App.css";
import "antd/dist/antd.css";
import Router from "./routes/Router";
import { factoryABI } from "./abi";
import Usefetch from "./utils/Usefetch";
import { ethers } from "ethers";
import dateinSec from "./utils/dateinSec";

function App() {
  const { enableWeb3, isAuthenticated } = useMoralis();
  const [contract, setContract] = useState(null)

  useEffect(() => {
    const provider = ethers.getDefaultProvider("rinkeby");
    const web3Provider = new ethers.providers.Web3Provider(window.ethereum,"any");

    // (async()=>{
    //   const signer = await web3Provider.getSigner();
    //   const contract = new ethers.Contract(
    //     process.env.REACT_APP_FACTORY_CONTRACT_ADD,
    //     factoryABI,
    //     signer
    //   );
    //   console.log("contract", contract);
    //   setContract(contract);
    // })()
    const contract = new ethers.Contract(
      process.env.REACT_APP_FACTORY_CONTRACT_ADD,
      factoryABI,
      provider
    );
    setContract(contract);
    if(isAuthenticated){
      enableWeb3();
    }
    
    
  }, [isAuthenticated]);

  return (
    <div className="App">
      {/* <button onClick={fetch}>setmaster</button> */}
      <Router contract={contract}/>
    </div>
  );
}

export default App;
