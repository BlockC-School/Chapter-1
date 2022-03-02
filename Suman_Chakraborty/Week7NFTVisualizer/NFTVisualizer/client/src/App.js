import "./App.css";
import React from "react";
import { Home } from "./components/Home";
// import { MoralisProvider, useMoralis } from "react-moralis";

function App() {
  // const appId = process.env.REACT_APP_MORALIS_APP_ID;
  // const serverUrl = process.env.REACT_APP_MORALIS_SERVER_URL;
  // const { Moralis } = useMoralis();
  // React.useEffect(() => Moralis.start({ serverUrl, appId }), []);
  return (
    <div className="App">
      <Home />
    </div>
  );
}

export default App;
