import contract from './contracts/OpenFund.json';
import './App.css';
import {useEffect, useState} from 'react';
import {ethers} from 'ethers';

// deployed contract address
const contractAddress = "0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3"; 
const abi = contract.abi;

function App() {
  const [currentAccount, setCurrentAccount] = useState(null);

  const CheckWalletIsConnected = async() => { 
    const { ethereum } = window;

    if (!ethereum) {
      console.log("May be you have not installed metamask");
      return;
    } else {
        console.log("Metamask is exists! We're working to add more Wallets ");
      const accounts = await ethereum.request({method: 'eth_accounts'});

      if (accounts.length !== 0) {
        const account = accounts[0];
        console.log("found an authorized account", account);
        setCurrentAccount(account);
      } else {
        console.log('no authorized accounts found')
      }
    }
  }
  
  const connectWalletHandler = async () => { 
    const { ethereum } = window;

    if (!ethereum) {
      alert('please instal metamask');
    }
    try{
      const accounts = await ethereum.request({method: "eth_requestAccounts"});
      console.log("found an account Address:", accounts[0]);
      setCurrentAccount(accounts[0]);
    } catch (err) {
      console.log(err);
    }
   }

  const fundHandler = async () => { 
    try {
      const {ethereum} = window;
      if (ethereum) {
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const fundContract = new ethers.Contract(contractAddress, abi, signer);
        
        console.log("initialized contract proccessing payment");
        let fundTxn = await fundContract.Fund(333, { value: ethers.utils.parseEther("0.003") });

        console.log('funding.. please wait');
        await fundTxn.wait();
        // getting txn hash with etherscan baseUri
        console.log(`Mined, transactiion: https://rinkeby.etherscan.io/tx/${fundTxn.hash}`);
       }
       else {
         console.log("Object not exist");
       }
    } catch (err) {
      console.log(err);
    }
  }
// connect wallet button
  const connectWalletButton = () => { 
    return (
      <button onClick={connectWalletHandler} className='cta-button connect-wallet-button'>
        Connect wallet
      </button>
    )
  }
  // Minting button
  const fundButton = () => {
    return (
      <button onClick={fundHandler} className='cta-button fund-button'>
        Contribute to needy 
      </button>
    )
  } 
  // useEffect provides react support
  useEffect(() => {
    CheckWalletIsConnected();
  },[])


  return (
    <div className='main-app'>
      <h1>Hekko world</h1>
      <div>
        {currentAccount ? fundButton(): connectWalletButton()}
      </div>
    </div>
  )
}

export default App;
