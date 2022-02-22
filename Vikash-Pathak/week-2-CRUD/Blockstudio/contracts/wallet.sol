// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract wallet {

    event Deposit(address sender, uint amount, uint balance);
    event Withdraw(uint amount, uint balance);
    event Transfer(address from, uint amount, address balance);

    address public owner;
    uint public balance;
    constructor ()  payable  {
        owner = msg.sender;
    }

    function deposit(address payable , uint ) public payable {
        emit Deposit(msg.sender, msg.value ,address(this).balance);
        // uint balance = address(this).balance;

        //   msg.sender.transfer(balance);
        // require(msg.value == _amount);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, 'you are NOt the owner');
        _;
    }

    function withdrawfunds(uint _amount) public onlyOwner {
        payable(msg.sender);
        // to.transfer(getBalance());
        // (msg.sender).transfer(address(this).balance);
        // owner.transfer(_amount);
        emit Withdraw(_amount, address(this).balance);
    }
    // function withdrawMoneyTo(address payable _to) public {
    //     _to.transfer(getBalance());
    // }

    function transfer(address payable _to, uint amount) public onlyOwner {
        _to.transfer(amount);
        // emit Transfer(_to, amount,address(this).balance);
    }
    function getBalance(address) public view returns (uint) {
        return address(this).balance;
    }

}
