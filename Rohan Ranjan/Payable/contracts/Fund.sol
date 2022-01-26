//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Fund {


    uint one = 1000000000000000000;


   function payEther() public payable {
    }

    function startTrancsaction(address _address,  uint _ether) public {
        bool status = checkValid(_address, _ether);
        uint reciverBalance = getBalance();
        address payable reciver = payable(address(this));
        console.log('Reciver Address => ', reciver);
        if(status){
            reciver.transfer(_ether);
            console.log('After Transaction Balance is => ', reciverBalance / one );
        }else{
            console.log(' Insufficent Fund !');
        }
    }

    function checkValid(address _address, uint _ether ) private returns(bool) {
        uint senderBalance = address(_address).balance;
        uint reciverBalance = getBalance();
        uint senderEtherValue = senderBalance / one;
        console.log('Before Transaction Balance is => ', reciverBalance / one);
        if( senderEtherValue > _ether){
            return true;
        }else{
            return false;
        }
    }

    function getBalance() private view returns(uint) {
        return address(this).balance;
    }

}
