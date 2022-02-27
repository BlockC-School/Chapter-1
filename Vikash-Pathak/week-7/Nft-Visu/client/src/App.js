
import './App.css';
import {ethers} from 'ethers';
import {useEffect} from "react";

function App() {
  useEffect (() => {
    if (process.env.REACT_APP_RINKEBY_PROVIDER) {
    const RpcEndpoint = process.env.REACT_APP_RINKEBY_PROVIDER;
    console.log(RpcEndpoint);
  }
    
    const ethersProvider = new ethers.providers.JsonRpcProvider(process.env.REACT_APP_RINKEBY);
    console.log(ethersProvider);
    
  }, []);
  

  return <div className="App"> </div>
}

export default App;
