//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract MultiSignerWallet {

    struct Transaction{
        uint id;
        address payable to;
        uint amount;
        bool isSent;
        uint approvals;
    }

    uint transactionIndex=0;

    address[] private owners;

    mapping(address => mapping(uint=>bool)) approvals;  //Approvals Object
    mapping(uint => Transaction) transactions;  //Transaction Object

    /**
    const owner1="0x12";
    const owner2="0x13";

    Txn1={
        id: 1
    }
    Txn2={
        id: 2
    }

    const approvals={
        "0x12":{
            "1":true,
            "2": false
        },
        "0x13":{
            "1":true,
            "2": true
        },
    }
    **/

    constructor(address[] memory _owners) {
        owners=_owners;
    }


    modifier authenticate(){
        bool isAllowed=false;

        for(uint i=0; i<owners.length; i++){
            if(owners[i] == msg.sender){
                isAllowed = true;
            }
        }

        require(isAllowed, "You are not the Owner");
        _;
    }

    modifier ifNotAnOwner(address _newOwner){
        bool isAllowed=true;

        for(uint i=0; i<owners.length; i++){
            if(owners[i] == _newOwner){
                isAllowed = false;
            }
        }

        require(isAllowed, "New Owner is Already an Owner");
        _;
    }

    modifier checkSentOrNot(uint _id){
        require(transactions[_id].isSent == false, "Transaction is already Sent");
        _;
    }

    modifier checkApprovals(uint _id){
        require(transactions[_id].approvals >= owners.length, "Transaction Requires Approvals");
        _;
    }


    function createTransaction(address payable _to, uint _amount) external authenticate returns(uint){
        transactions[transactionIndex] = Transaction(transactionIndex, _to, _amount, false, 0);
        transactionIndex ++;
        return transactionIndex - 1;
    }

    function signTransaction(uint _id) external authenticate{

        if(approvals[msg.sender][_id]  == false){
            approvals[msg.sender][_id]=true;
            transactions[_id].approvals ++;
        }

        require(approvals[msg.sender][_id], "Already Signed by You...");
    }


    function sendTransaction(uint _id) external authenticate checkSentOrNot(_id) checkApprovals( _id){
        transactions[_id].isSent=true;
        address payable to=transactions[_id].to;
        to.transfer(transactions[_id].amount);
        
    }


    function assignOwner(address _newOwner) external authenticate ifNotAnOwner(_newOwner){
        owners.push(_newOwner);
    }

    function getOwners() external view authenticate returns(address[] memory){
        return owners;
    }

}