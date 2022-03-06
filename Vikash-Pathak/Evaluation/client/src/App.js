import contract from './contracts/OpenFund.json';
import './App.css';
import {useEffect} from 'react';

// deployed contract address
const contractAddress = "0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3"; 
const abi = contract.abi;

function App() {
  const checkWalletIsConnected = () => { 
    const { ethereum } = window;

    if (!ethereum) {
      console.log("May be you have not installed metamask");
      return;
    } else {
        console.log("Metamask is exists! We're working to add more Wallets ")
      }
    }
   

  const connectWalletHandler = () => { }

  const mintNftHandler = () => { }
// connect wallet button
  const connectWalletButton = () => { 
    return (
      <button onClick={connectWalletHandler} className='cta-button connect-wallet-button'>
        Connect wallet
      </button>
    )
  }
  // Minting button
  const mintNftButton = () => {
    return (
      <button onClick={mintNftHandler} className='cta-button mint-nft-button'>
        Mint NFT 
      </button>
    )
  } 
  // useEffect provides react support
  useEffect(() => {
    checkWalletIsConnected();
  },[])


  return (
    <div className='main-app'>
      <h1>Hekko world</h1>
      <div>
        {connectWalletButton()}
      </div>
    </div>
  )
}

export default App;
