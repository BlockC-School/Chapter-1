//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Escrow{
    address private userA;
    address payable private userB;
    bool private isDone=false;

    constructor(){
        userA=msg.sender;
    }

    function getClient(address payable _developer) external payable {
        userB=_developer;
    }

    modifier isDeveloper(){
        require(msg.sender==userB, "Not a Developer");
        _;
    }
    modifier isClient(){
        require(msg.sender==userA, "Not the Owner");
        _;
    }
    modifier checkStatusByDeveloper(){
        require(!isDone, "Task is Not Done");
        _;        
    }
    modifier checkStatusByClient(){
        require(isDone, "Pay is not available as Task is Not Done");
        _;        
    }

    function doneWork() external isDeveloper checkStatusByDeveloper{
        isDone=true;
    }
    function doPayment() external isClient checkStatusByClient{
        uint amt=address(this).balance;
        userB.transfer(amt);
    }
}