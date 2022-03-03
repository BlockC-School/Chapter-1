
import './App.css';
import {ethers} from 'ethers';
import {useEffect} from "react";
// import  Web3 from 'web3';
import {BrowserRouter as Router, Switch, Route, NavLink} from "react-router-dom";
import Header from "./components/Header";

function App() {
  useEffect (() => {
  //   const web3Provider = 'https://rinkeby.infura.io/'
  //   const web3Instance = new Web3(new Web3.providers.HttpProvider(web3Provider));
  //   const w3signer = web3Instance.givenProvider.getSigner();
  //   console.log(w3signer);
    const NODE_URL= process.env.REACT_APP_RINKEBY;
    const ethersProvider = new ethers.providers.JsonRpcProvider(NODE_URL);
        const signer = ethersProvider.getSigner();
    console.log(signer, "signer");

  }, []);
  return (
      <div>
        {
              <Router>
              <Switch>
                  <>
              <Route exact path="/home" component={Header} />
                <NavLink to="/" />
              </>
              </Switch>
              </Router>
        }
      </div>
  );
  return <div className="App"> </div>;
}

export default App;
