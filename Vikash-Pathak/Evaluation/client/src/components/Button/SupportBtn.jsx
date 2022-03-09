import React from "react";
import styles from "./SupportButton.module.css";

const SupportButton = props => {
  return (
    <button className={styles.Button} onClick={props.onClick}>
      {props.children}
    </button>
  );
};

export default SupportButton;