import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import { dragonBallZCollectionAbi } from "../helper";
import axios from "axios";
import Onboard from "bnc-onboard";
import Button from "@mui/material/Button";
// import { useOnboard } from "use-onboard";
import Web3 from "web3";
import { CustomCard } from "./CustomCard";
import { NavBar } from "./NavBar";
import Grid from "@mui/material/Grid";
import { LoadingIndicator } from "./LoadingIndicator";
import LockOpenIcon from "@mui/icons-material/LockOpen";
import LogoutIcon from "@mui/icons-material/Logout";
import LoadingButton from "@mui/lab/LoadingButton";
import AccountCircleIcon from "@mui/icons-material/AccountCircle";

let web3;

const onboard = Onboard({
  dappId: process.env.REACT_APP_ONBOARD_API_KEY, // [String] The API key created by step one above
  networkId: 4, // [Integer] The Ethereum network ID your Dapp uses.
  subscriptions: {
    wallet: (wallet) => {
      web3 = new Web3(wallet.provider);
      // console.log(wallet);
      console.log(web3);
    },
  },
});

export const Home = () => {
  const [metaMaskWallet, setMetaMaskWallet] = useState(
    onboard.getState().address
      ? onboard.getState().address
      : "0x8A210cfC20504cAe244a12eb6b6D39556E6A1e58",
  );

  const [isLoading, setIsLoading] = useState(false);
  const [symbol, setSymbol] = useState("");
  const [name, setName] = useState("");
  const [tokenCount, setTokenCount] = useState("");
  const [balances, setBalances] = useState([]);
  const [baseUri, setBaseUri] = useState("");
  const [nftsMetaData, setNftsMetaData] = useState([]);

  // const account = "0x8A210cfC20504cAe244a12eb6b6D39556E6A1e58";

  const handleLoad = async () => {
    if (metaMaskWallet !== "") {
      setIsLoading(true);
      const ethersProvider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RINKEBY_URL,
      );

      const ethersSigner = ethersProvider.getSigner(metaMaskWallet);

      const dragonBallZCollection = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        dragonBallZCollectionAbi,
        ethersSigner,
      );

      const _symbol = await dragonBallZCollection.symbol();
      setSymbol(_symbol);

      const _name = await dragonBallZCollection.name();
      setName(_name);

      const _tokenCount = (await dragonBallZCollection.tokenCount()).toNumber();
      setTokenCount(_tokenCount);

      const _baseUri = await dragonBallZCollection.baseUri();
      setBaseUri(_baseUri);

      let accounts = Array(_tokenCount).fill(metaMaskWallet);
      let ids = Array.from(
        { length: _tokenCount },
        (value, index) => index + 1,
      );
      const _balances = (
        await dragonBallZCollection.balanceOfBatch(accounts, ids)
      ).map((item) => item.toNumber());
      setBalances(_balances);

      // console.log(await dragonBallZCollection.safeTransferFrom);
      // console.log(await dragonBallZCollection.owner());
      // console.log(
      //   (await dragonBallZCollection.balanceOf(account, 1)).toNumber(),
      // );

      //Transfer
      // await dragonBallZCollection.safeTransferFrom(
      //   account,
      //   "0xBfD90fa0C7382b4a003095314ca50C69e4EB0970",
      //   1,
      //   1,
      //   [],
      // );

      // console.log(
      //   (await dragonBallZCollection.balanceOf(account, 1)).toNumber(),
      // );

      _balances.forEach(async (bal, index) => {
        const { data } = await axios.get(`${_baseUri}${index + 1}.json`);
        // alert("Hi");
        // console.log(_baseUri);
        // data.balance = balance;
        setNftsMetaData((prev) => [...prev, { ...data, balance: bal }]);
        if (index === _balances.length - 1) {
          setIsLoading(false);
        }
      });
    } else {
      alert("Please connect to MetaMask");
    }
  };

  // const login = async () => {
  //   console.log(onboard.getState().address);
  //   await onboard.walletSelect();
  //   await onboard.walletCheck();
  //   (async () => setMetaMaskWallet(onboard.getState().address))();
  //   console.log(onboard.getState());
  // };

  const handleReset = () => {
    setSymbol("");
    setName("");
    setTokenCount("");
    setBalances([]);
    setBaseUri("");
    setNftsMetaData([]);
  };

  const handleLoginLogout = async () => {
    if (onboard.getState().address) {
      onboard.walletReset();
      setMetaMaskWallet("");
      handleReset();
    } else {
      await onboard.walletSelect();
      await onboard.walletCheck();
      (async () => setMetaMaskWallet(onboard.getState().address))();
    }
  };

  // console.log(nftsMetaData);

  useEffect(handleLoad, [metaMaskWallet]);

  return (
    <div>
      <NavBar
        handleLoginLogout={handleLoginLogout}
        buttonContent={
          onboard.getState().address ? <LogoutIcon /> : <LockOpenIcon />
        }
        buttonString={onboard.getState().address ? "Logout" : "Login"}
        tokenCount={tokenCount}
        baseUri={baseUri}
      />
      <br />
      <div>
        <Grid container spacing={3}>
          <Grid item xs={6}>
            {name === "" ? (
              isLoading && (
                <LoadingButton loading={isLoading} variant="outlined" disabled>
                  Fetching
                </LoadingButton>
              )
            ) : isLoading ? (
              <LoadingButton loading={isLoading} variant="outlined" disabled>
                Fetching
              </LoadingButton>
            ) : (
              <Button color="secondary" variant="contained">
                Collection
              </Button>
            )}
          </Grid>
          <Grid item xs={6}>
            {name !== "" && (
              <LoadingButton
                color="secondary"
                loading={isLoading}
                loadingPosition="start"
                startIcon={<AccountCircleIcon />}
                variant="contained"
              >
                {name}
              </LoadingButton>
            )}
          </Grid>
        </Grid>
      </div>

      {isLoading ? (
        <LoadingIndicator />
      ) : nftsMetaData.length === 0 ? (
        <div>
          <img src="./no_data_found.png" alt="No Display" />
        </div>
      ) : (
        <Grid
          container
          spacing={2}
          sx={{
            marginTop: "50px",
            // border: "1px solid red",
            margin: "auto",
            width: "1050px",
            marginBottom: "20px",
          }}
        >
          {nftsMetaData.map((nft, index) => {
            return (
              nft.balance > 0 && (
                <Grid key={index} container item xs={6}>
                  <CustomCard
                    nft={nft}
                    symbol={symbol}
                    noOfAmount={balances[index]}
                  />
                </Grid>
              )
            );
            // console.log(nft);
          })}
        </Grid>
        // <div>
        //   <h3>Collection Name: {name}</h3>
        //   <h5>Collection Symbol: {symbol}</h5>
        //   <h5>Base URI: {baseUri}</h5>
        //   <h5>Minted: {tokenCount}</h5>
        // </div>
      )}
    </div>
  );
};
