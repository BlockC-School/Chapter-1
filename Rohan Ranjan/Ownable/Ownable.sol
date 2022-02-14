// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */


contract Ownable{

    address public owner; // here we store our owner address

    constructor(){
        owner = msg.sender; // here we are setting our owner, with global varibale msg.sender which gives address how call or deploy this contract
    }

    // creating modifier for like to check some function only be called my current owner
    modifier onlyOwner(){
        require(msg.sender == owner, "not owner");
        _;
    }

    // in setNewOwner function can all called by current owner, and set new owner
    function setNewOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid address"); // here we are checking for like null value.
        owner = _newOwner; // here we are changing owner.
    }

    function allOwner() external {
        // this function can be call by any one.
    }

    function onlyByCurrentOwner() external onlyOwner {
        // this function can be only called by current owner.
    }
}