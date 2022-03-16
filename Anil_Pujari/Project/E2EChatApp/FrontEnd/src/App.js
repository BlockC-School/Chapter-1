import Chat from "./chat/chat";
import Process from "./process/process";
import Home from "./home/home";
import { BrowserRouter as Router, Routes as Switch , Route, useParams } from "react-router-dom";
import "./App.scss";
import React from "react";
import io from "socket.io-client";

const socket = io.connect('/');
function Appmain(props) {
  const {roomname,username} = useParams();
  return (
    <React.Fragment>
      <div className="right">
        <Chat
          username={username}
          roomname={roomname}
          socket={socket}
        />
      </div>
      {/* <div className="left">
        <Process />
      </div> */}
    </React.Fragment>
  );
}
function App() {
  return (
    <Router>
      <div className="App">
        <Switch>
          <Route exact path="/" element={<Home socket={socket} />} />
            
          <Route path="/chat/:roomname/:username" element={<Appmain/>} />
        </Switch>
      </div>
    </Router>
  );
}

export default App;
