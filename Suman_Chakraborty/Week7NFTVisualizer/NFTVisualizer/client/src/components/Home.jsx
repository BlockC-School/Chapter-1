import React, { useEffect, useState } from "react";
// import { ethers } from "ethers";
// import { dragonBallZCollectionAbi } from "../helper";
import axios from "axios";
import Onboard from "bnc-onboard";
// import Button from "@mui/material/Button";
// import { useOnboard } from "use-onboard";
import Web3 from "web3";
import { CustomCard } from "./CustomCard";
import { NavBar } from "./NavBar";
import Grid from "@mui/material/Grid";
import { LoadingIndicator } from "./LoadingIndicator";
import LockOpenIcon from "@mui/icons-material/LockOpen";
import LogoutIcon from "@mui/icons-material/Logout";
import { useMoralis } from "react-moralis";

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
    onboard.getState().address ? onboard.getState().address : "",
  );

  console.log(onboard.getState());

  const { Moralis } = useMoralis();
  const [isLoading, setIsLoading] = useState(false);
  const [nftsData, setNftsData] = useState([]);

  const handleGetAllNFTS = async (results) => {
    const nfts = await Promise.all(
      results.map(async (result, index) => {
        const { data } = await axios.get(result.token_uri);
        return { ...result, metadata: data };
      }),
    );
    console.log(nfts);
    setNftsData(nfts);
    setIsLoading(false);
  };

  const handleLoad = async () => {
    if (metaMaskWallet !== "") {
      console.log("MetaMask is Connected", metaMaskWallet);
      setIsLoading(true);

      //Creating provider
      // const ethersProvider = new ethers.providers.JsonRpcProvider(
      //   process.env.REACT_APP_RINKEBY_URL,
      // );

      const options = { chain: "rinkeby", address: metaMaskWallet };
      // const NFTs = await Moralis.Web3API.token.getAllTokenIds(options);
      const nfts = await Moralis.Web3API.account.getNFTs(options);
      setNftsData(nfts.result);

      if (nfts.result.length === 0) {
        console.log("No NFT is found");
        setIsLoading(false);
      } else {
        console.log("NFTs are found");
        handleGetAllNFTS(nfts.result);
      }

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

      // _balances.forEach(async (bal, index) => {
      //   const { data } = await axios.get(`${_baseUri}${index + 1}.json`);
      //   setNftsData((prev) => [...prev, { ...data, balance: bal }]);
      //   if (index === _balances.length - 1) {
      //     setIsLoading(false);
      //   }
      // });
    }
  };

  const handleLoginLogout = async () => {
    if (onboard.getState().address) {
      onboard.walletReset();
      setMetaMaskWallet("");
      setNftsData([]);
      // handleReset();
    } else {
      await onboard.walletSelect();
      await onboard.walletCheck();
      (async () => setMetaMaskWallet(onboard.getState().address))();
    }
  };

  useEffect(handleLoad, [metaMaskWallet]);

  return (
    <div>
      <NavBar
        handleLoginLogout={handleLoginLogout}
        buttonContent={
          onboard.getState().address ? <LogoutIcon /> : <LockOpenIcon />
        }
        buttonString={onboard.getState().address ? "Logout" : "Login"}
        metaMaskWallet={metaMaskWallet}
        isLoading={isLoading}
      />
      <br />

      {isLoading ? (
        <LoadingIndicator />
      ) : nftsData.length === 0 ? (
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
            maxWidth: "85%",
            marginBottom: "20px",
          }}
        >
          {nftsData.map((nft, index) => {
            return (
              nft.amount > 0 && (
                <Grid key={index} container item xs={12} md={6}>
                  <CustomCard nft={nft} />
                </Grid>
              )
            );
          })}
        </Grid>
      )}
    </div>
  );
};
