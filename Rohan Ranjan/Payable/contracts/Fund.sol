//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Fund {


    uint one = 1000000000000000000;
    uint amount;

    // function payMe() external payable {
    //     address payable reciver = payable(address(this));
    //     reciver.transfer(amount);
    // }


    function payMe() private {
        address payable reciver = payable(address(this));
        reciver.transfer(amount);
    }


    function startTrancsaction(address _address,  uint _ether) public {
        bool status = checkValid(_address, _ether);
        amount = _ether;
        uint balContract = getBalance();
        if(status){
           payMe();
            console.log('After Transaction Balance is => ', balContract / one );
        }else{
            console.log(' Insufficent Fund !');
        }
    }

    function checkValid(address _address, uint _ether ) private returns(bool) {
        uint bal = address(_address).balance;
        uint balContract = getBalance();
        console.log('Before Transaction Balance is => ', balContract / one );
        if( (bal/one) < _ether){
            return true;
        }else{
            return false;
        }
    }

    function getBalance() private view returns(uint) {
        return address(this).balance;
    }

}
