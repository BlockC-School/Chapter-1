//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Payable{

  function acceptBalance () external payable {
    console.log("Ether accepted");
  }
  function getBalance() external view returns(uint){
    return address(this).balance;
  }
}
