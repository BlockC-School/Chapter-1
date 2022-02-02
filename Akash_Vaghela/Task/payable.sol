//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.6;

contract PayableWallet {

    function payableFunc() public payable {
    }

    function getTotalFund () public view returns (uint) {
        // uint totalFundsInEther = address(this).balance * 10 ** 18;
        return address(this).balance;
    }

    function sendFund (address payable _to, uint _fund) public {
        if(_fund >= address(this).balance){
            revert("Can't Send Funds, Decrease Amount");
        }

        require(_fund <= address(this).balance, "Insufficient Funds, Try later.");
        
        _to.transfer(_fund);
    }
}
