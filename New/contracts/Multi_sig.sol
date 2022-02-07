// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.6;

contract Multi_sig{
    // requirement for multi-sig wallet
    address mainOwner;  
    // list of owners
    address[] walletOwners;
    uint transferId = 0;

    uint balances;
    mapping(address => uint) balance;

    struct Transaction{
        address sender;
        address receiver;
        uint amount;
        uint transferId;
        uint approvalCount;
        uint approval_TransactionTime;
    }
    Transaction[] transaction_request;

    event wallet_ownerAdded(address addedyBy, address newOwner, uint index);
    event wallet_ownerRemoved(address removedBy, address owner_removed, uint index);
    event funds_deposited(address from, uint amount, uint index);
    event funds_withdrawd(address from, uint amount, uint index);
    event tranfer_created(address sender,address receiver,uint amount, uint id, uint approval,uint timestamp);

    constructor() {
        mainOwner = msg.sender;
        walletOwners.push(msg.sender);
        } 

    modifier onlyOwner() {
         bool isOwner = false;
        for (uint i =0; i < walletOwners.length; i++) {
            if (walletOwners[i] == msg.sender) {
                isOwner = true;
                break;
            }
        }
        require(isOwner == true, 'only wallet owners call this function');
        _;
    }

    function addOwner(address owner) public onlyOwner{    
        for (uint i =0; i < walletOwners.length; i++) {
            if (walletOwners[i] == owner) {
                revert('cannot add duplicate owner');
            }
        }
        walletOwners.push(owner);
        emit wallet_ownerAdded(msg.sender, owner, walletOwners.length - 1);
    }
    function delOwner(address owner) public onlyOwner {
        bool alreadyDeleted = false;
        uint ownerIndex;
        for (uint i =0; i < walletOwners.length; i++) {
            if (walletOwners[i] == owner) {
                alreadyDeleted = true;
                ownerIndex = i;
                break;
            }
        }
        require(alreadyDeleted == true, ' owner not detected');
        walletOwners[ownerIndex] = walletOwners[walletOwners.length - 1];
        walletOwners.pop();
        emit wallet_ownerRemoved(msg.sender, owner, block.timestamp);
    }
    function deposit(uint amount) public payable onlyOwner{
        require(msg.value >= amount, 'deposit amount must be greater than or equal to the amount');
        require(amount > 0, 'deposit amount must be greater than 0');
        require(msg.sender == mainOwner, 'only main owner can deposit');
        require(balance[msg.sender] >= msg.value, 'insufficient balance');
        balance[msg.sender] = msg.value;
        emit funds_deposited(msg.sender, msg.value, block.timestamp);
    }
    function withdraw(uint amount) public onlyOwner{
        require(amount > 0, 'withdraw amount must be greater than 0');
        require(balance[msg.sender] >= 0, 'insufficient balance');
        balance[msg.sender] = balance[msg.sender] - amount;
        payable(msg.sender).transfer(amount);
        emit funds_withdrawd(msg.sender, amount, block.timestamp);
    }
    function createTransaction(address receiver, uint amount) public onlyOwner{
        require(msg.sender != receiver, 'no fraud');
        require(balance[msg.sender] >= amount, 'insufficient balance');
        // Transaction.push(transfer(msg.sender, receiver, amount , ))
        transaction_request.push(Transaction(msg.sender, receiver, amount, transferId, 0, block.timestamp)); 
        transferId++;

        emit tranfer_created(msg.sender, receiver, amount, transferId, 0, block.timestamp);
    }
    function getbalance() public view returns (uint){
        return balance[msg.sender];
    }
    function getWalletOwner( ) public view returns (address[] memory) {
        return walletOwners;
    }
    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }
}

