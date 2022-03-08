import React from 'react'
import { Tooltip } from 'antd';
import { useMoralis } from "react-moralis";
import Button from '../Button/Button'
import { UnlockFilled, WalletFilled  } from '@ant-design/icons';
import logo from '../../assets/images/logo.jpg'
import metamaskicon from '../../assets/images/metamask.webp';
import './Header.scss'
export default function Header() {
    const { authenticate, isAuthenticated, user, logout } = useMoralis();

    const handleAuthentication = () => {
        if(isAuthenticated){
            logout();
        } else {
            authenticate({ signingMessage: "Authenticate" });
        }
    }

    React.useEffect(() => {
        if (isAuthenticated) {
            console.log(user, user.get("username"));
        }
    }, [user, isAuthenticated])
  return (
    <div className='header_container'>
        <div>
            <div className='logo_container'>
             <img src={logo} alt="logo" />
            </div>
            
        </div>
        <div>
        { isAuthenticated && user && <Tooltip title={user.get('ethAddress')}> <Button  style={{backgroundColor: 'transparent', color: '#4cc899', width: '200px'}} icon={<img className='metamask_icon' src={metamaskicon} alt="metamask_icon"/>} type='text'>CONNECTED TO WALLET</Button></Tooltip>}
        <Button onClick={handleAuthentication} style={{backgroundColor: 'transparent', color: 'black', width: '150px'}} icon={<WalletFilled style={{color: '#4cc899'}} />} type='text'>{isAuthenticated ? 'DISCONNECT': 'CONNECT'}</Button>
            {/* <Button style={{width: '250px', height: '50px'}} >START A CAMPAIGN</Button> */}
        </div>
    </div>
  )
}
