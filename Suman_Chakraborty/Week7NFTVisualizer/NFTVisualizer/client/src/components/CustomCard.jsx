import React from "react";
import Card from "@mui/material/Card";
import CardHeader from "@mui/material/CardHeader";
import CardMedia from "@mui/material/CardMedia";
import CardContent from "@mui/material/CardContent";
import CardActions from "@mui/material/CardActions";
import Avatar from "@mui/material/Avatar";
import IconButton from "@mui/material/IconButton";
import Typography from "@mui/material/Typography";
import ShareIcon from "@mui/icons-material/Share";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import SellIcon from "@mui/icons-material/Sell";

export const CustomCard = ({ nft, symbol }) => {
  const { name, image, balance, description } = nft;

  return (
    <Card sx={{ maxWidth: 500, cursor: "pointer" }}>
      <CardHeader
        avatar={
          <Avatar sx={{ backgroundColor: "#ff9900", padding: "2px 2px" }}>
            {symbol}
          </Avatar>
        }
        action={
          <IconButton>
            <MoreVertIcon />
          </IconButton>
        }
        title={<h2>{name}</h2>}
      />
      <IconButton>
        <CardMedia
          component="img"
          height="400"
          image={image}
          alt="Token Image"
        />
      </IconButton>
      <CardContent>
        <Typography variant="body2" color="text.secondary">
          {description}
        </Typography>
      </CardContent>
      <CardActions
        sx={{
          display: "flex",
          justifyContent: "space-between",
          margin: "auto",
          maxWidth: "75%",
        }}
      >
        <IconButton>
          <SellIcon />
          <span>{balance}</span>
        </IconButton>
        <IconButton>
          <ShareIcon />
        </IconButton>
      </CardActions>
    </Card>
  );
};
