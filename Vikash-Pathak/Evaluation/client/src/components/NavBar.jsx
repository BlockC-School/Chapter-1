import React from 'react'
import CustomBtn from './action/FundBtn'
// import logo from '../logo.svg'
import {Toolbar, Typography} from '@material-ui/core'
import {makeStyles} from "@material-ui/core/styles"; 
import Header from './action/Onboard';

const styles = makeStyles({
    bar:{
        paddingTop: "1.15rem",
        backgroundColor: "#fff",
        flexDirection: "column"
    },
    // logo: {
    //     width: "15%", 
    //     ['@media (max-width:780px)']: { 
    //        display: "none"
    //        }
    // },
    menuItem: {
        cursor: "pointer", 
        flexGrow: 1,
        paddingBottom: "1rem",
        "&:hover": {
            color:  "#4f25c8"
        },
         
    }
})

function NavBar() {
    const classes = styles()
    return (
            <Toolbar position="sticky" color="rgba(0, 0, 0, 0.87)" className={classes.bar}>   
                {/* <img src={logo} className={classes.logo}/>  */}
                <Typography variant="h6" className={classes.menuItem}>
                   About
                </Typography>
                <Typography variant="h6" className={classes.menuItem}>
                    Blog
                </Typography>
                <Typography variant="h6" className={classes.menuItem}>
                    Campaingns
                </Typography>
                <Typography variant="h6" className={classes.menuItem}>
                    Donated Story 
                </Typography>
                <Typography variant="h6" className={classes.menuItem}>
                    <Header>
                    Donate Us
                    </Header> 
                </Typography>
                <CustomBtn txt="Support Our Effort"/>
            </Toolbar>
    )
}

export default NavBar