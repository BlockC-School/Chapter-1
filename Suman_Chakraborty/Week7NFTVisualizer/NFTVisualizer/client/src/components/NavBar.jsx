import React from "react";
import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import IconButton from "@mui/material/IconButton";

import Button from "@mui/material/Button";

export const NavBar = ({ handleLoginLogout, buttonContent, buttonString }) => {
  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static">
        <Toolbar
          sx={{
            // border: "2px solid red",
            display: "flex",
            justifyContent: "space-between",
          }}
        >
          <Typography variant="h4" component="div" sx={{ fontSize: "25px" }}>
            𝑹𝒂𝒋𝒂𝒎𝒐𝒕𝒐 𝑽𝒊𝒔𝒖𝒂𝒍𝒊𝒛𝒆𝒓
          </Typography>

          <div>
            <IconButton
              size="large"
              aria-label="account of current user"
              aria-controls="menu-appbar"
              aria-haspopup="true"
              onClick={handleLoginLogout}
              color="inherit"
            >
              <Button
                variant="contained"
                endIcon={buttonContent}
                color="secondary"
              >
                {buttonString}
              </Button>
              {/* <span style={{ fontSize: "20px", marginRight: "5px" }}>
                  {buttonString}
                </span>
                {buttonContent} */}
            </IconButton>
          </div>
        </Toolbar>
      </AppBar>
    </Box>
  );
};
