//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Escorw {
    address payable public userA;
    address public userB;
    bool status = false;

    constructor(address payable _userA, address _userB) public {
        userA = _userA;
        userB = _userB;
    }

    modifier isUserB() {
        require(msg.sender == userB, 'Only UserB can call this...');
        _;
    }

    modifier isUserA() {
         require(msg.sender == userA, 'Only UserA can call this...');
        _;
    }

    function workCompleted() isUserB public payable {
        status = true;
    }

    function transferFund() isUserA public {
        if(status){
            userA.transfer(address(this).balance);
            console.log('Transfer of Fund is completed');
        }else{
            console.log('UserB does not coniform');
        }
    }
}
