import React from "react";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import Modal from "@mui/material/Modal";
import Slider from "@mui/material/Slider";

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: "90%",
  maxWidth: "500px",
  bgcolor: "background.paper",
  border: "2px solid #000",
  boxShadow: 24,
  p: 4,
};

export const AttributeCard = ({
  isOpen,
  handleOpenModal,
  attributes,
  collectionName,
}) => {
  console.log("isOpen", isOpen);
  console.log("AttributeCard", attributes);

  return (
    <Modal open={isOpen}>
      <Box sx={style}>
        {attributes.length >= 1 &&
          attributes.map((attribute) => {
            const marks = [
              {
                value: 0,
                label: "0",
              },
              {
                value: attribute.value * 10,
                label: `${attribute.value}`,
              },
              {
                value: attribute.max_value * 10,
                label: `${attribute.max_value}`,
              },
            ];
            return (
              <>
                <span>{attribute.trait_type}</span>
                <Slider
                  disabled
                  color="secondary"
                  defaultValue={attribute.value * 10}
                  step={50}
                  marks={marks}
                  sx={{ color: "#3A677D" }}
                ></Slider>
              </>
            );
          })}
        <Button
          variant="outlined"
          color="secondary"
          onClick={() => handleOpenModal(false)}
        >
          Cancel
        </Button>
      </Box>
    </Modal>
  );
};
