//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.6;

contract MultiSignWallet {

    struct Owner {
        uint id;
        address ownerAddress;
    }

    struct Transaction{
        uint id;
        uint amount;
        address payable to;
        uint[] approvedBy;
        bool isCompleted;
    }

    Owner[] internal ownersArr;
    Transaction[] internal transactionArr;

    constructor () public {
        ownersArr.push(Owner(1, msg.sender));
    }

    function payableFunc() public checkIfOwner payable {
    }

    function addOwner (address _newOwner) public checkIfOwner {
        uint newID = ownersArr.length + 1;
        ownersArr.push(Owner(newID, _newOwner));
        return;
    }

    function getTransaction (uint _id) public view returns (uint, address, uint[] memory, bool) {
        return (transactionArr[_id].amount, transactionArr[_id].to, transactionArr[_id].approvedBy, transactionArr[_id].isCompleted);
    }

    function addTransaction (uint _amount, address payable _to) public {
        uint newID = transactionArr.length + 1;
        uint[] memory approvalArr;
        transactionArr.push(Transaction(newID, _amount, _to, approvalArr, false));
        return;
    }

    function approveTransaction (uint _id) public checkIfOwner  checkIfAlreadyApproved(_id) {
        uint ownerID = searchOwner(msg.sender);
        transactionArr[_id].approvedBy.push(ownerID);
        return;
    }

    function releaseFunds (uint _id) public checkIfOwner checkStatus(_id){
        address payable txAddress = transactionArr[_id].to;
        uint txAmount = transactionArr[_id].amount;

        txAddress.transfer(txAmount);
        transactionArr[_id].isCompleted = true;
    }

    modifier checkIfAlreadyApproved(uint _id) {
        bool status = false;
        uint[] memory txAppr = transactionArr[_id].approvedBy;
        uint ownerID = searchOwner(msg.sender);
        
        for(uint i = 0; i < txAppr.length; i++){
            if(txAppr[i] == ownerID){
                revert("Transaction Already Approved by You!!");
            }
        }
        
        _;
    }

    modifier checkStatus(uint _id){
        require(transactionArr[_id].isCompleted == false, "Transaction Already Completed!!");
        _;
    }

    modifier checkIfOwner (){
        bool owner = false;
        for(uint i = 0; i < ownersArr.length; i++){
            if(ownersArr[i].ownerAddress == msg.sender){
                owner = true;
                continue;
            }
        }

        require(owner == true, "Not an authorized person to perform this action !!");
        _;
    }

    function searchOwner(address _address) internal returns (uint) {
        for(uint i = 0; i < ownersArr.length; i++){
            if(ownersArr[i].ownerAddress == _address){
                return ownersArr[i].id;
            }
        }
    }
}
