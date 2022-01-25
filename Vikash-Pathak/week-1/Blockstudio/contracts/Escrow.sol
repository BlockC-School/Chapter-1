// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EscrowCont{
    // Escrow contract that have only one user_A and one user_B
    // user_A is the owner of the contract
    // user_B is the receiver of the contract
    // user_A set the amount of money that user_B need to pay
    address user_A;
    address user_B;
    mapping(address => uint) public deposits;

    modifier onlyOwner() {
        if (msg.sender == user_A) {
            _;
        } 
    }

    constructor () {
        user_A = msg.sender;
    }

    function Deposit(address payer) public onlyOwner payable {
        uint256 amount = msg.value;
        deposits[payer] = deposits[payer] + amount;
    }

    function withdrraw(address payable payer) public onlyOwner {
        // require(deposits[payer] >= amount);
        // deposits[payer] = deposits[payer] - amount;
        uint256 payment = deposits[payer];
        deposits[payer] = 0;
        payer.transfer(payment);
    }
    
}
