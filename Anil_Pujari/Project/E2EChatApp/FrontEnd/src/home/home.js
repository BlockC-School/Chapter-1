import React, { useState } from "react";
import "./home.scss";
import { Link, useNavigate } from "react-router-dom";
import { to_Encrypt } from './../aes';

function Homepage({ socket }) {
  const [username, setusername] = useState("");
  const [roomname, setroomname] = useState("");
  const [secret, setsecret] = useState("");
  const navigate = useNavigate();
  const sendData = () => {
    if (username !== "" && roomname !== "" && secret !== "") {
      // socket.emit("joinRoom", { username, roomname });
      sessionStorage.setItem("secret", to_Encrypt(secret));
      navigate(`/chat/${roomname}/${username}`);
    } else {
      alert("username and roomname are must !");
      window.location.reload();
    }
  };

  return (
    <div className="homepage">
      <h1>Welcome to ChatApp</h1>
      <input
        placeholder="Enter your username"
        value={username}
        onChange={(e) => setusername(e.target.value)}
      ></input>
      <input
        placeholder="Enter room name"
        value={roomname}
        onChange={(e) => setroomname(e.target.value)}
      ></input>
         <input
        placeholder="Enter your Secret Password"
        value={secret}
        onChange={(e) => setsecret(e.target.value)}
      ></input>
    
    
        <button onClick={sendData}>Join</button>
   
    </div>
  );
}

export default Homepage;
