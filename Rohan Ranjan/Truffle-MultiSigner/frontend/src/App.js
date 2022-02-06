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
  const [ownerAddress, setOwnerAdress] = React.useState("")
  const [addOwnerStatus, setAddOwnerStatus] = React.useState(false)
  const [startTransStatus, setStartTransStatus] = React.useState(false)
  const [form, setForm] = React.useState(init)

  React.useEffect(() => {
    getAllOwnerLists()
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
    const provider = await new ethers.providers.JsonRpcProvider("HTTP://127.0.0.1:7545", 1337)
    // console.log("Provider => ", provider)
    return provider
  }

  const stateAddOwner = () => {
    setAddOwnerStatus(prev => !prev)
  }

  const stateTrans = () => {
    setStartTransStatus(prev => !prev)
  }

  const formChange = (e) => {
    const {name, value} = e.target;
    setForm({...form, [name]: value})
  }

  const addOwners = async () => {
    const provider = await getProvider();
    const signer = provider.getSigner();
    const wallet = await new ethers.Contract(Abi.networks["5777"].address, Abi.abi, signer);
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
    const wallet = await new ethers.Contract(Abi.networks["5777"].address, Abi.abi, provider);
    // console.log("Wallet is => ", wallet, provider)
    try{
    const allOwnerList = await wallet.getAllOwnerList()
    setData(allOwnerList)
    console.log("Data : ", allOwnerList)
    }catch(error){
      console.log("Error getAllOwnerLists : ", error)
    }
  }

  const sendMoney = async (e) => {
    e.preventDefault();
    const provider = await getProvider();
    const signer = provider.getSigner();
    const wallet = await new ethers.Contract(Abi.networks["5777"].address, Abi.abi, signer);
    try{
      if(form.money !== 0&& form.to !== ""){
        let trans = await wallet.transaction(form.to, form.money);
        trans = await trans.wait();
        console.log("Transaction => ", trans.value);
      }else{
        alert("Invalid Data !");
      }
    }catch(error){
      console.log("Error sendMoney : ", error);
    }
  }
  return (
    <>
    <div>
      <button onClick={stateAddOwner}>Add Owner</button>
      {data.length !== 0 && <button onClick={stateTrans}>Send Eather</button>}
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
            <button onClick={sendMoney}>OK</button>
          </form>
          </div>}
    </div>
    {data.length !== 0 && <p>Total Approver's: {data.length} </p>}
    <div>
      {data && data.map((item, index) => <div key={item.ownerAddress}>
        <p>{index+1}.)   {item.ownerAddress}</p>
      </div>)}
    </div>
    </>
  );
}

export default App;
