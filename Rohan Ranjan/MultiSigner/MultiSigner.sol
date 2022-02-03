// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract MultiSigner {

    struct OwnerList {
        address ownerAddress;
        bool status;
        uint id;
    }

    OwnerList[] public owner;
    uint public uniqueId;

    constructor(){
        uniqueId = 0;
    }

    function isOnOwnerList(address _add) private view returns(bool){
        for(uint i = 0; i < owner.length; i++){
            if(owner[i].ownerAddress ==  _add){
                return true;
            }
        }
        return false;
    }

    function addOwner(address _add) public returns(string memory){
        bool status = isOnOwnerList(_add);
        if(status){
            return "You are already in owner list !";
        }
        OwnerList memory temp = OwnerList(_add, false, uniqueId);
        owner.push(temp);
        uniqueId++;
        return "Owner added successfully !";
    }

    modifier onlyOwner(){
        bool status = isOnOwnerList(msg.sender);
        require(status == true, "You are not in owner list !");
        _;
    }

    modifier isOnOwnerListThere(){
        require(owner.length != 0, "There should be minimum one owner list");
        _;
    }

    function approved(address _add) private {
        for(uint i = 0; i < owner.length; i++){
            if(owner[i].ownerAddress ==  _add){
                owner[i].status = true;
            }
        }
    }

    function approveTransaction() public returns(string memory){
        bool status = isOnOwnerList(msg.sender);
        if(status){
            approved(msg.sender);
            return "Approved";
        }else{
             return "You are not in ower list, addyourself";
        }
    }

    function allOwnersAreApproved() private view returns(uint){
        uint count = 0;
        for(uint i = 0; i < owner.length; i++){
            if(owner[i].status == true){
                count++;
            }
        }

        return count;
    }

    function setStatusBack() private view {
        for(uint i = 0; i < owner.length; i++){
            owner[i].status == false;
        }
    }

    function getAllOwnerList() public view returns(OwnerList[] memory){
        return owner;
    }

    function transaction(address payable reciver, uint _amount) public payable returns(string memory){
        uint count = allOwnersAreApproved();
        if(count == owner.length){
             uint price = _amount * (1 ether);
            reciver.transfer(price);
            setStatusBack();
            return "Transaction sucessfully completed !";
        }else{
            return "Some owner's not approved";
        }

    }

}
