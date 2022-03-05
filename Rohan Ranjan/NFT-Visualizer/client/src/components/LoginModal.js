import Web3 from 'web3';
import Web3Modal from "web3modal";
import Authereum from "authereum";
import WalletConnectProvider from "@walletconnect/web3-provider";
import react from "react";

export default function wallet_model() {
    const [loading, setLoading] = react.useState(false);
    return {
    get web3Loading() {
    return loading
    },
    async getweb3() {
    setLoading(true);
    let web3Modal;
    let provider;
    let web3;
    let providerOptions;
    providerOptions = {
    metamask: {
    id: "injected",
    name: "MetaMask",
    type: "injected",
    check: "isMetaMask"
    },
    walletconnect: {
        package: WalletConnectProvider, // required
        options: {
        infuraId: process.env.REACT_APP_INFURA_ID, // Required
        network: "rinkeby",
        qrcodeModalOptions: {
        mobileLinks: [
        "rainbow",
        "metamask",
        "argent",
        "trust",
        "imtoken",
        "pillar"
        ]
        }
        }
        },
        authereum: {
            package: Authereum // required
            },
            };
            web3Modal = new Web3Modal({
            network: "rinkeby",
            cacheProvider: true,
            providerOptions
            });
            provider = await web3Modal.connect();
            provider.on("error", e => console.error("WS Error", e));
            provider.on("end", e => console.error("WS End", e));
            
            provider.on("disconnect", (error) => {
                console.log("Yhaoo")
            });
            provider.on("connect", (info) => {
            console.log(info);
            });
            web3 = new Web3(provider);
            setLoading(false);
            return web3;
            },
            }
            }
            