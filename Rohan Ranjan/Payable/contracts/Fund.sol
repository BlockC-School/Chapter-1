//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Fund {


    uint amount;

    function checkSufficientFund() private returns(uint) {
        return address(this).balance;
    }

    function payAmount(address _add, uint _price) public payable returns(string memory){
        uint contractBalance = checkSufficientFund();
        contractBalance = contractBalance * (1 ether);
        amount = _price * (1 ether);
        address payable payee = payable(address(this));
        if(amount <= contractBalance){
            payee.transfer(amount);
            return "Transfer Complete !";
        }else{
            return "Invalid Amount";
        }
    }

}
