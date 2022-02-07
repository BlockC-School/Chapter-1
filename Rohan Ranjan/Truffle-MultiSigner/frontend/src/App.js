import React from "react"
import './App.css';
import { ethers } from "ethers";
import Abi from "./Abi.json"

const init = {
  to: "",
  money: 0
}

function App() {

  const [data, setData] = React.useState([]);
  const [ownerAddress, setOwnerAdress] = React.useState("");
  const [addOwnerStatus, setAddOwnerStatus] = React.useState(false);
  const [startTransStatus, setStartTransStatus] = React.useState(false);
  const [coniformTxd, setConifromTxd] = React.useState(false);
  const [executeTxd, setExecuteTxd] = React.useState(false);
  const [form, setForm] = React.useState(init)
  const [coniformTxdId, setConifromTxdId] = React.useState("")
  const [executeTxdId, setExecuteTxdId] = React.useState("");
  const [transData, setTransData] = React.useState([])

  React.useEffect(() => {
    getAllOwnerLists()
    getTransactionData()
  }, []);

  React.useEffect(() => {
    if(!addOwnerStatus){
      setOwnerAdress("")
    }
  }, [addOwnerStatus])

  React.useEffect(() => {
    if(!startTransStatus){
      setForm(init)
    }
  }, [startTransStatus])

  const getProvider = async () => {
    const provider = await new ethers.providers.JsonRpcProvider("HTTP://127.0.0.1:7545", 1337);
    // const wallet = await new ethers.Contract(Abi.networks["5777"].address, Abi.abi, provider);
    // console.log("Provider => ", await provider.listAccounts());
    // console.log("Wallet is => ", wallet);
    return provider
  }

  const stateAddOwner = () => {
    setAddOwnerStatus(prev => !prev)
    setConifromTxd(false)
    setExecuteTxd(false)
    setStartTransStatus(false)
  }

  const coniformTxdStatus = () => {
    setConifromTxd(prev => !prev)
    setAddOwnerStatus(false)
    setExecuteTxd(false)
    setStartTransStatus(false)
  }

  const executeTxdStatus = () => {
    setExecuteTxd(prev => !prev)
    setConifromTxd(false)
    setAddOwnerStatus(false)
    setStartTransStatus(false)
  }

  const stateTrans = () => {
    setStartTransStatus(prev => !prev)
    setAddOwnerStatus(false)
    setConifromTxd(false)
    setExecuteTxd(false)
  }

  const formChange = (e) => {
    const {name, value} = e.target;
    setForm({...form, [name]: value})
  }

  const forGetDataWallet = async (provider) => {
    const wallet = await new ethers.Contract(Abi.networks["5777"].address, Abi.abi, provider);
    return wallet;
  }

  const forPostDataWallet = async (signer) => {
    const wallet = await new ethers.Contract(Abi.networks["5777"].address, Abi.abi, signer);
    return wallet;
  }

  const getTransactionData = async () => {
    const provider = await getProvider();
    const wallet = await forGetDataWallet(provider);
    try{
      let data = await wallet.getTransactionDetails();
      console.log("txd data => ", data)
    }catch(error){
      console.log("Error getTransactionData : ", error)
    }
  }

  const addOwners = async () => {
    const provider = await getProvider();
    const signer = provider.getSigner();
    const wallet = await forPostDataWallet(signer)
    try{
      if(ownerAddress !== ""){
        const trans = await wallet.addOwner(ownerAddress);
        await trans.wait();
        getAllOwnerLists()
        setOwnerAdress("")
        setAddOwnerStatus(false)
      }else{
        alert("Invalid address !")
      }
    }catch(error){
      console.log("Error addOwners : ", error)
    }
  }
  

  const getAllOwnerLists = async () => {
    const provider = await getProvider();
    const wallet = await forGetDataWallet(provider);
    try{
    const allOwnerList = await wallet.getAllOwnersList()
    setData(allOwnerList)
    console.log("Data : ", allOwnerList)
    }catch(error){
      console.log("Error getAllOwnerLists : ", error)
    }
  }

  const createTransaction = async (e) => {
    e.preventDefault();
    const provider = await getProvider();
    const signer = provider.getSigner();
    const wallet = await forPostDataWallet(signer)
    try{
      if(form.money !== 0&& form.to !== ""){
        let trans = await wallet.submitTransaction(form.to, form.money, {from: "0x7494B508840f31fB9Ca6656ECc3BfC08b2c4abBB"});
        trans = await trans.wait();
        console.log("Transaction => ", trans.value);
        getTransactionData()
      }else{
        alert("Invalid Data !");
      }
    }catch(error){
      console.log("Error createTransaction : ", error);
    }
  }

  const coniformTransactions = async () => {
    const provider = await getProvider();
    const signer = provider.getSigner();
    const wallet = await forPostDataWallet(signer)
    try{

      if(coniformTxdId !== ""){
        let trans = await wallet.coniformTransaction(+coniformTxdId);
        trans = await trans.wait()
        console.log("trnas coniformTransactions ", trans)
      }else{
        alert("Invalid transaction id !")
      }

    }catch(error){
      let err = JSON.parse(error.body);
      alert(err.error.message)
    }
  }

  const executeTransactions = async () => {
    const provider = await getProvider();
    const signer = provider.getSigner();
    const wallet = await forPostDataWallet(signer)
    try{

      if(executeTxdId !== ""){
        let trans = await wallet.executeTransaction(+executeTxdId);
        trans = await trans.wait()
        console.log("trnas executeTransactions ", trans)
      }else{
        alert("Invalid transaction id !")
      }

    }catch(error){
      let err = JSON.parse(error.body);
      alert(err.error.message)
    }
  }
  return (
    <>
    <div>
      <button onClick={stateAddOwner}>Add Owner</button>
      {data.length !== 0 && <button onClick={stateTrans}>Create Transaction</button>}
      {data.length !== 0 && <button onClick={coniformTxdStatus}>Conifrom Transaction</button>}
      {data.length !== 0 && <button onClick={executeTxdStatus}>Execute Transaction</button>}
      <br></br>
      <br></br>
      {addOwnerStatus && <div>
        <input placeholder="address" onChange={(e) => setOwnerAdress(e.target.value)} />
        <button onClick={addOwners}>Submit</button>
        </div>}
        {startTransStatus && <div>
          <form>
          <label>To Address</label>
            <input placeholder="address" name="to" value={form.to} onChange={formChange} />
            <label>Amount</label>
            <input placeholder="address" name="money" value={form.money == 0 ? "" : form.money } onChange={formChange} />
            <button onClick={createTransaction}>OK</button>
          </form>
          </div>}
          {coniformTxd && <div>
            <input placeholder="enter transaction id" value={coniformTxdId} onChange={(e) => 
            setConifromTxdId(e.target.value)} />
            <button onClick={coniformTransactions}>OK</button>
            </div>}
          {executeTxd && <div>
            <input placeholder="enter transaction id" value={executeTxdId} onChange={(e) => 
            setExecuteTxdId(e.target.value)} />
             <button onClick={executeTransactions}>OK</button>
            </div>}
    </div>
    {data.length !== 0 && <p>Total Approver's: {data.length} </p>}
    <div>
      {data && data.map((item, index) => <div key={item.ownerAddress}>
        <p>{index+1}.)   {item}</p>
      </div>)}
    </div>
    <div style={{width: "100%", border: "2px solid red"}}></div>
    {transData.length !== 0 && <p>Total Transaction: {transData.length} </p>}
    <div>
      {transData && transData.map((item, index) => <div key={item.to}>
        <p>{index+1}.)   {item}</p>
      </div>)}
    </div>
    </>
  );
}

export default App;
