//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract CrowdFund{
    mapping (address => uint256) public contributors;  //"0x89594": 1
    uint256 public noOfContributors;
    address [] private contributorList;
    address public seeker;
    uint256 public minimumDonation;
    uint256 public deadline;
    uint256 public targetFund;
    string public description;
    string public image;
    uint256 public collectedAmount;

    constructor(uint256 _minimumDonation, uint256 _deadline, uint256 _targetFund, string memory _description, string memory _image){
        seeker = msg.sender;
        minimumDonation = _minimumDonation;
        deadline = block.timestamp + _deadline * 24 * 3600;
        targetFund = _targetFund;
        description = _description;
        image = _image;
    }

    //Checks msg.sender is contributor or not
    modifier onlyContributor {
        require(contributors[msg.sender] > 0, "You are not a contributor");
        _;
    }

    //Checks msg.sender is seeker or not
    modifier onlySeeker {
        require(msg.sender == seeker, "You are not the authorised person");
        _;
    }

    //Send ether to the smart contract
    function sendDonation() public payable{
        require(block.timestamp < deadline, "Deadline is gone");
        require(msg.value >= minimumDonation, "Minimum Donation is not met");

        if(contributors[msg.sender] == 1){
            noOfContributors ++;
        }

        contributors[msg.sender] += msg.value;
        collectedAmount += msg.value;
    }

    //Get Balance of the Smart Contract
    function getContractBalance() public view returns (uint256){
        return address(this).balance;
    }

    //Contributor can ask for money refund as per sole policy
    function demandRefund() onlyContributor public {
        require(block.timestamp > deadline && collectedAmount < targetFund, "Either deadline is not pass or collected amount met the target");
        address payable _contributor = payable(msg.sender);
        uint256 _contribution = contributors[msg.sender];
        //Refund the exact money that a contributor contributes
        _contributor.transfer(_contribution);
        //Make the record update that refund is done
        contributors[msg.sender] = 0;
    }

    //Seeker can withdraw the collected amount only after the deadline && after target fulfilled
    function acceptDonation() onlySeeker public {
        require(block.timestamp > deadline, "Deadline is not passes");
        require(collectedAmount >= targetFund, "Target is not fulfilled");

        address payable _seeker = payable (msg.sender);
        _seeker.transfer(collectedAmount);

        for(uint256 i=0; i < contributorList.length; i++){
            address _contributor = contributorList[i];
            contributors[_contributor] = 0;
        }

        collectedAmount = 0;

    }

}
