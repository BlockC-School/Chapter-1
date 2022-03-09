import React from "react";
import { Routes as Switch, Route } from "react-router-dom";
import Home from "./../Components/Home/Home";
import CampaignDetails from "./../Components/CampaignPage/CampaignDetails";
import Header from "../Components/Header/Header";

export default function Router({contract}) {
  return (
    <div>
      <Header/>
      <Switch>
        <Route exact path="/" element={<Home contract={contract} />} />
        <Route  path="/campaign/:addr" element={<CampaignDetails contract={contract}/>} />
        <Route path="*" element={<h1>Page Not Found!</h1>} />
      </Switch>
    </div>
  );
}
