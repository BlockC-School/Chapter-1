import React from "react";
import Skeleton from "@mui/material/Skeleton";
import Stack from "@mui/material/Stack";

export const LoadingIndicator = () => {
  return (
    <Stack spacing={5} sx={{ maxWidth: "1200px", margin: "auto" }}>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="100%" height={60} />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="30%" />
        <Skeleton variant="rectangular" width="20%" />
        <Skeleton variant="rectangular" width="30%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="15%" />
        <Skeleton variant="rectangular" width="70%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="90%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="60%" />
        <Skeleton variant="rectangular" width="25%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="15%" />
        <Skeleton variant="rectangular" width="70%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="30%" />
        <Skeleton variant="rectangular" width="20%" />
        <Skeleton variant="rectangular" width="30%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="15%" />
        <Skeleton variant="rectangular" width="70%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="60%" />
        <Skeleton variant="rectangular" width="25%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="15%" />
        <Skeleton variant="rectangular" width="70%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="30%" />
        <Skeleton variant="rectangular" width="20%" />
        <Skeleton variant="rectangular" width="30%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="90%" />
      </div>
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <Skeleton variant="rectangular" width="60%" />
        <Skeleton variant="rectangular" width="25%" />
      </div>
    </Stack>
  );
};
