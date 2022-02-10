pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */

 // Coustom error used for reduce the gas fees.
 // How we are doing:
 // exmaple: suppose when we put condition like using require:
 // ex 1> require(msg.sender == owner, "not owner") // here we have short error message, but suppose we have large error message like:
 // ex 2> require(msg.sender == owner, "not owner error error error error error") // it will take more gas fees as compare to 1 ex.
 // here custome error come in picture.

contract Ownable{

    address public owner; // here we store our owner address

    error NotOwner(address sender); // now coustom error only be used with revert.
    error InvalidAddress();

    constructor(){
        owner = msg.sender; // here we are setting our owner, with global varibale msg.sender which gives address how call or deploy this contract
    }

    // in setNewOwner function can all called by current owner, and set new owner
    function setNewOwner(address _newOwner) external  {
        if(msg.sender == owner){
            if(_newOwner != address(0)){ // here we are checking for like null value.
                owner = _newOwner;
            }else{
                revert InvalidAddress(); // this is our custom, error
            }
        }else{
            revert NotOwner(msg.sender); // // this is our custom, error
        }
    }

    function allOwner() external view {
        // this function can be all by any one.
    }

    function onlyByCurrentOwner() external view {
        // this function can be only called by current owner.
        if(msg.sender == owner){
            // success
        }else{
             revert NotOwner(msg.sender); // // this is our custom, error
        }
    }
}