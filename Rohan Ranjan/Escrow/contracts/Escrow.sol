//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Escorw {
    enum Status {
        NOT_INITIATED,
        AWATING_PAYMENT,
        AWATING_DELIVERY,
        PROCESS_COMPLETED
    }

    bool public isUserA;
    bool public isUserB;

    Status public currentStatus;

    uint public price;

    address public userB;
    address payable public userA;

    modifier onlyForUserB(){
        require(msg.sender == userB, "Only UserB can call this function !");
        _;
    }

    modifier notStarted(){
        require(currentStatus == Status.NOT_INITIATED, "Not started yet !");
        _;
    }

    constructor(address _userB, address payable _userA, uint _price){
        userB = _userB;
        userA = _userA;
        price = _price * (1 ether);
    }

    function initiateContract() notStarted public {
        if(msg.sender == userB){
            isUserB = true;
        }

        if(msg.sender == userA){
            isUserA = true;
        }

        if(isUserB && isUserA){
            currentStatus = Status.AWATING_PAYMENT;
        }
    }

    function coniformPayment() onlyForUserB payable public {
        require(currentStatus == Status.AWATING_DELIVERY, "Cannot coniform payment !");
        userA.transfer(price);
        currentStatus = Status.PROCESS_COMPLETED;
    }

    function deposit() onlyForUserB payable public {
        require(currentStatus == Status.AWATING_PAYMENT, "Already paid !");
        require(msg.value == price, 'Wrong amount');
        currentStatus = Status.AWATING_DELIVERY;
    }
}
