// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract CroudFunding {
    address public admin;
    uint256 public deadline;
    uint256 public target;
    uint256 public minContribution;
    uint256 public raisedAmount;
    uint256 public NoOfCountributers;
    string public description;
    mapping(address => uint256) public Contributers;

    constructor(uint256 _target, uint256 _deadline, string memory _description){
        target = _target;
        deadline = block.timestamp + _deadline;    //in seconds
        description = _description;
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
        require(msg.value >= minContribution, "Please send Min. 100wei");

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
        Contributers[msg.sender] = 0; 
    }
    
    function GetDonation() public OnlyAdmin {
        require(block.timestamp <= deadline && raisedAmount >= target, "Raised amount did not reached to target amount");

        address payable _Doner = payable(msg.sender);
        _Doner.transfer(raisedAmount);

        // for(uint256 i=0; i<Contributers.length; i++) {
        //     address _contributer = Contributers[i];
        //     Contributers[_contributer] = 0;
        // }
        raisedAmount = 0;
    }
}