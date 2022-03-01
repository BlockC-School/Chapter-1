import {ethers} from "ethers"
import React, {useEffect, useState} from "react"
import {ABI} from "./ABI"
import Container from './components/Container';
import css from "./App.module.css"
import LoginModal from "./components/LoginModal"
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';

// webiste link:  https://ournftvisualiser.netlify.app/

function App() {

  const [wallet, setWallet] = useState(null);
  const [connected, setConnected] = useState(false)
  const [accountAddress, setAccountAddress] = useState('')

  const {web3Loading, getweb3} = LoginModal();

  const connectWallet = async () => {
    await getweb3().then((res) => {
      console.log("getWeb3 response is => ", res)
      res.eth.getAccounts().then((res) => {
        setAccountAddress(res[0])
        setConnected(true)
      })
    })
  }

  const disconnectWallet = async () => {
   let ok =  await (await getweb3()).setProvider(null)
   setConnected(false)
   setAccountAddress('')
  }

  useEffect(() => {
    if(connected && accountAddress){
      const provider = new ethers.providers.JsonRpcBatchProvider(process.env.REACT_APP_RINKEBY_NETWORK_URL)

    const wallet = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, ABI, provider);
    setWallet(wallet)
    }
  }, [connected])
  return (
    <>
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            NFT Visualizer
          </Typography>
          {accountAddress &&  <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            {accountAddress}
          </Typography>}
          <Button color="inherit" onClick = {connectWallet}>{web3Loading ? 'Connecting' : connected ? 'Connected' : 'Connect To Wallet'}</Button>
          {connected && <Button color="inherit" onClick = {disconnectWallet}>Disconnect</Button>}
        </Toolbar>
      </AppBar>
    </Box>
    {connected && <div className={css.super_main}>
      {wallet && connected && accountAddress && <Container wallet = {wallet} accountAddress = {accountAddress} />}
    </div>}
    </>
  );
}

export default App;
