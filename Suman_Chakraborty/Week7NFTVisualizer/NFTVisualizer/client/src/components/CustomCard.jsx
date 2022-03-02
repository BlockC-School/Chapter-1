import React from "react";
import Card from "@mui/material/Card";
import CardHeader from "@mui/material/CardHeader";
import CardMedia from "@mui/material/CardMedia";
import CardContent from "@mui/material/CardContent";
import CardActions from "@mui/material/CardActions";
import Avatar from "@mui/material/Avatar";
import IconButton from "@mui/material/IconButton";
import Typography from "@mui/material/Typography";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import SellIcon from "@mui/icons-material/Sell";
import IosShareIcon from "@mui/icons-material/IosShare";
import { AttributeCard } from "./AttributeCard";

export const CustomCard = ({ nft }) => {
  const { name, symbol, amount, metadata } = nft;
  const { image, description, attributes } = metadata;
  const nftName = metadata.name;

  const [isOpen, setIsOpen] = React.useState(false);

  const handleOpenModal = (value) => {
    setIsOpen(value);
  };

  return (
    <Card
      sx={{
        width: "100%",
        maxWidth: "100%",
        cursor: "pointer",
        background: "#e4d6d6",
      }}
    >
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
        title={<h2>{nftName}</h2>}
        subheader={<h4>{`Collection Of ${name}`}</h4>}
      />

      <IconButton onClick={() => handleOpenModal(true)}>
        <CardMedia
          component="img"
          height="400"
          image={image}
          alt="Token Image"
        />
      </IconButton>
      <CardContent>
        <Typography variant="body2" sx={{ color: "black", fontSize: "15px" }}>
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
          <span>{amount}</span>
        </IconButton>
        <IconButton>
          <IosShareIcon />
        </IconButton>
      </CardActions>
      {isOpen && (
        <AttributeCard
          isOpen={isOpen}
          handleOpenModal={handleOpenModal}
          attributes={attributes}
          collectionName={name}
        />
      )}
    </Card>
  );
};
