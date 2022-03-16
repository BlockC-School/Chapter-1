import "./chat.scss";
import { to_Decrypt, to_Encrypt } from "../aes.js";
import React, { useState, useEffect, useRef } from "react";


function Chat({ username, roomname, socket }) {
  const [text, setText] = useState("");
  const [messages, setMessages] = useState([]);


  useEffect(() => {
    socket.on("message", (data) => {
      //decypt
      const secret_key = sessionStorage.getItem("secret");
      const decrypt_key = to_Decrypt(secret_key)
      const ans = to_Decrypt(data.text, data.username, decrypt_key);
      //dispatchProcess(false, ans, data.text);
      console.log(ans);
      let temp = messages;
      temp.push({
        userId: data.userId,
        username: data.username,
        text: ans,
        encryptedText: data.text,
      });
      setMessages([...temp]);
    });
  }, [socket]);


  const sendData = () => {
    if (text !== "") {
      //encrypt here
      const secret_key = sessionStorage.getItem("secret");
      const decrypt_key = to_Decrypt(secret_key)
      const ans = to_Encrypt(text, decrypt_key);
      socket.emit("chat", ans);
      setText("");
    }
  };
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(scrollToBottom, [messages]);

  console.log(messages, "mess");

  useEffect(()=>{
    if (username !== "" && roomname !== "") {
      socket.emit("joinRoom", { username, roomname });
    } 
  },[])


  return (
    <div className="chat">
      <div className="user-name">
        <h2>
          {username} <span style={{ fontSize: "0.7rem" }}>in {roomname}</span>
        </h2>
      </div>
      <div className="chat-message">
        {messages.map((i) => {
          if (i.username === username) {
            return (
              <div className="message">
                <p>{i.text}</p>
                <span>{i.username}</span>
              </div>
            );
          } else {
            return (
              <div className="message mess-right">
                <p>{i.text} </p>
                <span>{i.username}</span>
              </div>
            );
          }
        })}
        <div ref={messagesEndRef} />
      </div>
      <div className="send">
        <input
          placeholder="enter your message"
          value={text}
          onChange={(e) => setText(e.target.value)}
          onKeyPress={(e) => {
            if (e.key === "Enter") {
              sendData();
            }
          }}
        ></input>
        <button onClick={sendData}>Send</button>
      </div>
    </div>
  );
}
export default Chat;
