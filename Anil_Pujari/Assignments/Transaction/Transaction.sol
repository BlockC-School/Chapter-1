// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Transaction {

    

    function payEther() public payable {

    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function sentEtherToAccount(address _receiver) public {
       address payable user = payable(_receiver);
       user.transfer(1 ether);
    }
 
}