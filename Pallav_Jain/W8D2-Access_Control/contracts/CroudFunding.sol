// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract CroudFunding {
    address public admin;
    uint256 public deadline;
    uint256 public target;
    uint256 public minContribution;
    uint256 public raisedAmount;
    uint256 public NoOfCountributers;
    mapping(address => uint256) public Contributers;

    struct Request{
        string description;
        uint256 value;
        bool completed;
        address payable reciepent;
    }

    mapping(uint256 => Request) public requests;
    uint public numRequests;

    constructor(uint256 _target, uint256 _deadline){
        target = _target;
        deadline = block.timestamp + _deadline;    //in seconds
        minContribution = 100 wei;
        admin = msg.sender;
    }

    modifier OnlyAdmin() {
        require(msg.sender == admin, "You are not an Admin");
        _;
    }

    function SendEthers() public payable {
        require(msg.sender != admin, "You are an admin you cannot be Contribute");
        require(block.timestamp < deadline, "Deadline is Passed");
        require(msg.value >= minContribution, "Please send the Min. 100wei");

        if(Contributers[msg.sender] == 0) {
            NoOfCountributers++;
        }

        Contributers[msg.sender] += msg.value;
        raisedAmount += msg.value; 
    }

    function getBalance() public view  returns (uint) {
        return address(this).balance;
    }


    function refund() public {
        require(Contributers[msg.sender] > 0, "You have'n contributed any amount");
        require(block.timestamp < deadline && raisedAmount < target, "You are nor Elagible for the refund");

        address payable user = payable(msg.sender);
        user.transfer(Contributers[msg.sender]);
    }


    function createRequests(string memory _description, uint256 _value, address payable _reciepent) public OnlyAdmin {
         Request storage newrequest = requests[numRequests];
         numRequests++;

         newrequest.description = _description;
         newrequest.reciepent = _reciepent;
         newrequest.value = _value;
         newrequest.completed = false;
    }
    
    function makePayment(uint256 _requestNumber) public OnlyAdmin {
        require(raisedAmount >= target, "Raised amount did not reached to target amount");
        Request storage newPayment = requests[_requestNumber];
        require(newPayment.completed == false, "You have aready paid");

        newPayment.reciepent.transfer(newPayment.value);
        newPayment.completed = true;
        raisedAmount -= newPayment.value;
    }
}