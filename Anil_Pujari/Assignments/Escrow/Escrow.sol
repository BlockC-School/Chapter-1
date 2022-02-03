// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Escrow{
    address public owner=msg.sender;
    bool locked;
    struct person{
       uint amount;
       bool isComplete;
       bool ispaid;
       address wallet_add;
    }

    mapping(address => person) freelancer;

    function depositAmount() public payable {}


    modifier ownerPermit() {
    require(msg.sender==owner,"Only owner have permit");
    _;
    }

modifier freelancerPermit() {

    require(freelancer[msg.sender].wallet_add==msg.sender,"Don't have acesss.Only freelancer have acesss");
    _;
  }

  modifier allPermit() {
    require(freelancer[msg.sender].wallet_add==msg.sender|| msg.sender==owner,"Only owner and freelancer have access!");
    _;
  }

  modifier verifyAmount(address _add){
      require(address(this).balance>=freelancer[_add].amount, "Don't have enough amount");
      _;
  }
modifier noReentrancy(){
    require(!locked, "No noReentrancy");
    locked= true;
    _;
    locked=false;
}


    function createNewContract(address _to, uint _pay) public ownerPermit noReentrancy{
      person memory newPerson = person({
           amount: _pay,
           isComplete: false,
           ispaid: false,
           wallet_add: _to
       });
       freelancer[_to] = newPerson;
    }

    function showContract(address _add) public allPermit view returns(uint, bool,bool, address) {
        address _to= msg.sender;
        if(msg.sender==owner){
           _to= _add;
        }
        return (freelancer[_to].amount,freelancer[_to].isComplete,freelancer[_to].ispaid,freelancer[_to].wallet_add);
    }

    function isWorkComplete(address _add) public view ownerPermit returns(string memory){
       if(freelancer[_add].isComplete){
           return "Work is Completed!";
       } else {
           return "Opps, not completed!";
       }
    }
     function isgetPaid(address _add) public view ownerPermit returns(string memory){
       if(freelancer[_add].ispaid){
           return "freelancer get paid";
       } else {
           return "Not get paid yet!";
       }
    }

    function updateMyWorkStatus() public freelancerPermit returns(string memory){
       freelancer[msg.sender].isComplete= true;
       return "Congratualtion! You completed the work.";
    }

     function getBalance() public view ownerPermit returns (uint) {
        return address(this).balance;
    }

    function payToFreelancer(address _add) public ownerPermit verifyAmount(_add) noReentrancy returns(string memory){
        address payable _to = payable(_add);
        if(freelancer[_add].isComplete && !freelancer[_add].ispaid){
        _to.transfer(freelancer[_add].amount);
        freelancer[_add].ispaid = true;
        return "Transfer Successfully !";
        } else if(freelancer[_add].ispaid){
            return "freelancer already get paid";
        }
        else {
            return "Opps, can't transfer. Work is not done yet ! ";
        }
    }
}