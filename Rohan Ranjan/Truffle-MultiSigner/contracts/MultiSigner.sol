// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract MultiSigner {

    struct Transaction {
        address payable to;
        uint value;
        bool executed;
        uint limit;
        uint id;
        mapping(address => bool) isConiformed;
    }

    struct Temp {
        address to;
        uint value;
        bool executed;
        uint limit;
        uint id;
    }
     Temp[] temp;
    Transaction[] public transactions;
    address[] owners;
    uint public approversLimit;
    mapping(address => bool) isOwner;

    constructor(address[] memory _owner, uint _limit){
        require(_owner.length > 0, "Owners Required !");
        require(_limit > 0 && _limit <= _owner.length, "Invalid number of required approver's !");
        for(uint i = 0; i < _owner.length; i++){
            address owner = _owner[i];
            require(owner != address(0), "Invalid Owner !");
            require(!isOwner[owner], "Owner not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }
        approversLimit = _limit;
    }

    modifier onlyOwner(){
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExits(uint _txId){
        require(_txId < transactions.length, "transaction does not exit");
        _;
    }

    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed, "transaction already executed");
        _;
    }

    modifier notConiform(uint _txId){
        require(!transactions[_txId].isConiformed[msg.sender], "transaction already coniformed");
        _;
    }

    function addOwner(address _add) public onlyOwner{
        owners.push(_add);
    }

    function getAllOwnersList() public view returns(address[] memory){
        return owners;
    }

    function getTransactionDetails() public view returns(Temp[] memory){
        return temp;
    }

    function submitTransaction(address payable _to, uint _value) public onlyOwner {
        uint nextId = transactions.length;
        Transaction storage txd = transactions.push();
        txd.to = _to;
        txd.value = _value;
        txd.id = nextId;
        txd.executed = false;
        txd.limit = 0;

        Temp memory t1 = Temp(_to, _value, false, 0, nextId);
        temp.push(t1);
    }

    function coniformTransaction(uint _txId) public onlyOwner txExits(_txId) notExecuted(_txId) notConiform(_txId) {
        Transaction storage txd = transactions[_txId];
        txd.isConiformed[msg.sender] = true;
        txd.limit += 1;
    }

    function executeTransaction(uint _txId) public onlyOwner txExits(_txId) notExecuted(_txId){
        Transaction storage txd = transactions[_txId];
        require(txd.limit >= approversLimit, "connot execute, some approver's not approve transaction !");
        txd.executed = true;
        uint amount = txd.value * 10 ** 18;
        address payable to = txd.to;
        (bool sent, ) = to.call{value: amount}("");
        require(sent, "transfer failed");
    }
}
