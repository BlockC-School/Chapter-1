import React from "react";
import {ethers} from "ethers";
import Employee from "./Employee.json"

const contractAddress = '0x5fbdb2315678afecb367f032d93f642f64180aa3';
const accountAdress = '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266'
const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80'
const delpoyeContractAdress = '0x5FbDB2315678afecb367f032d93F642f64180aa3'
const publicAddress = '0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc'

const form = {
  name: '',
  age: 0,
  email: '',
  walletAdress: ''
}

function App() {
  const [data, setData] = React.useState([]);
  const [userForm, setUserForm] = React.useState(form)

  React.useEffect(() => {
    // requestAccount()
    fetchEmployeeData()
  }, [])

  const requestAccount = async () => {
    await window.ethereum.request({method: accountAdress})
  }

  const handelChange = (e) => {
    const {name, value} = e.target
    setUserForm({...userForm, [name]: value})
  }

  const addEmployee = async () => {
    if (typeof window.ethereum !== 'undefined') {
      await requestAccount()
      const provider = new ethers.providers.Web3Provider(window.ethereum, 'any')
      const signer = provider.getSigner()
      const contract = new ethers.Contract(contractAddress, Employee.abi, signer)
      try {
        const {name, age, email, walletAdress} = userForm
        const trans = await contract.addEmployeeData(name, age, email, walletAdress)
        await trans.wait()
        setUserForm(form)
        fetchEmployeeData()
      } catch (err) {
        console.log("Error from : addEmployee ", err)
      }
    }    
  }

  const fetchEmployeeData = async () => {
    if (typeof window.ethereum !== 'undefined') {
      const provider = new ethers.providers.Web3Provider(window.ethereum)
      const contract = new ethers.Contract(contractAddress, Employee.abi, provider)
      try {
        const data = await contract.getAllEmployeeData()
        console.log('Data is => ', data)
        setData(data)
      } catch (err) {
        console.log("Error from : fetchEmployeeData ", err)
      }
    }    
  }
  return (
    <>
    <div>
      <input type={'text'} placeholder="name" value={userForm.name} name="name" onChange={handelChange} />
      <input type={'number'} placeholder="age" value={userForm.age} name="age" onChange={handelChange} />
      <input type={'text'} placeholder="email" value={userForm.email} name="email" onChange={handelChange} />
      <input type={'text'} placeholder="wallet address" value={userForm.walletAdress} name="walletAdress" onChange={handelChange} />
      <button onClick={addEmployee}>ADD</button>
    </div>
    <div>
      {data && data.map((item) => <div key={item.id}>
        <p> {item.name} </p>
        <p> {item.age} </p>
        <p> {item.email} </p>
        <p> {item.walletAdress} </p>
      </div>)}
    </div>
    </>
  );
}

export default App;