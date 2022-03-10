// import contract from '../contracts/OpenFund.json';
import './App.css';
import NavBar  from '../NavBar';
import {useEffect, useState} from 'react';
import {ethers} from 'ethers';
import { Grid } from '@material-ui/core';
// For Theme and UI
import { createTheme, ThemeProvider, makeStyles } from '@material-ui/core/styles';
import {Typography} from '@material-ui/core';
import Footer from '../Footer'

//changes to imports 
import SecurityIcon from '@material-ui/icons/Security';
import EventNoteIcon from '@material-ui/icons/EventNote';
import TrendingUpIcon from '@material-ui/icons/TrendingUp';
import ImportExportIcon from '@material-ui/icons/ImportExport';
import ComputerIcon from '@material-ui/icons/Computer';
import HttpIcon from '@material-ui/icons/Http';
import Header from '../action/Onboard';
// End
// deployed contract address
const contractAddress = "0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3"; 
// const abi = contract.abi;

// Theme

const theme = createTheme({
  palette: {
    primary: {
      main:"#2e1667",
    },
    secondary: {
      main:"#c7d8ed",
    },
  },
  typography: {
    fontFamily: [
      'Roboto'
    ],
    h4: {
      fontWeight: 600,
      fontSize: 28,
      lineHeight: '2rem',
      },
    h5: {
      fontWeight: 100,
      lineHeight: '2rem',
    },
  },
});

const styles = makeStyles({
  wrapper: {
    width: "65%",
    margin: "auto",
    textAlign: "center"
  },
  bigSpace: {
    marginTop: "5rem"
  },
  littleSpace:{
    marginTop: "2.5rem",
  },
  grid:{
    display: "flex", 
    justifyContent: "center",
    alignItems: "center",
    flexWrap: "wrap", 
  },
})
//
function Welco() {
  //Theme
  const classes = styles();
  //
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
        const fundContract = new ethers.Contract(contractAddress, signer);
        
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
    
    <div className="App">   
      <Grid />
      <NavBar/>
        <div className='main-app'>
        <h1>Support Who Want</h1>
        
        <div>
          {currentAccount ? fundButton(): connectWalletButton()}
        </div>
        </div>
    <ThemeProvider theme={theme}>
      
      <div className={classes.wrapper}>
        <Typography variant="h4" className={classes.bigSpace} color="primary">
            We are passionate to Help
        </Typography>
        <Typography variant="h5" className={classes.littleSpace} color="primary">
          If you help a soul as a Human Being .Karma will repeat it same with you.
        </Typography>
      </div>
      <div className={`${classes.grid} ${classes.bigSpace}`}>
        <Grid icon={<SecurityIcon style={{fill: "#4360A6", height:"125", width:"125"}}/>}  title="Secure" btnTitle="Show me More" />
        <Grid icon={<EventNoteIcon style={{fill: "#449A76", height:"125", width:"125"}}/>} title="Reliable" btnTitle="Show me More"/>
        <Grid icon={<TrendingUpIcon style={{fill: "#D05B2D", height:"125", width:"125"}}/>}  title="Performant" btnTitle="Show me More"/>
      </div>
      <div className={`${classes.grid} ${classes.littleSpace}`}>  
        <Grid icon={<ImportExportIcon style={{fill: "#5EA780", height:"125", width:"125"}}/>}  title="Modular" btnTitle="Show me More"/>
        <Grid icon={<ComputerIcon style={{fill: "#E69426", height:"125", width:"125"}}/>}  title="Multi-Platform" btnTitle="Show me More"/>
        <Grid icon={<HttpIcon style={{fill: "#2EA09D", height:"125", width:"125"}}/>} title="Connected" btnTitle="Show me More"/>
      </div>
      <div className={classes.bigSpace}>
        
      </div>
    </ThemeProvider>
    <Header />
    <Footer />
  </div>
  
  )
}

export default Welco;
