import React from "react";
import {ethers} from "ethers";
import Employee from "./Employee.json"

const contractAddress = '0x8230d15fED1e2E5EE9473851602265c3CEE199Fa';
const accountAdress = '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
const KEY = process.env.REACT_APP_PRIAVTE_KEY || ''

const provider = ethers.getDefaultProvider(4)
const wallet = new ethers.Wallet(KEY, provider);

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
    fetchEmployeeData()
  }, [])

  const handelChange = (e) => {
    const {name, value} = e.target
    setUserForm({...userForm, [name]: value})
  }

  const addEmployee = async () => {
    const signer  = wallet.connect(provider)
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

  const fetchEmployeeData = async () => {
    const contract = new ethers.Contract(contractAddress, Employee.abi, provider)
    try {
      const data = await contract.getAllEmployeeData()
      console.log('Data is => ', data)
      setData(data)
    } catch (err) {
      console.log("Error from : fetchEmployeeData ", err)
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