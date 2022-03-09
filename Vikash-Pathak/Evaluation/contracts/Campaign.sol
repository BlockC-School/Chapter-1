// SPDX-License-Identifier: MIT
import  "./OpenFund.sol";
// import "../@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
// import "../@openzeppelin/contracts/access/Ownable.sol";
import './IERC20.sol';
pragma experimental ABIEncoderV2;
pragma solidity >=0.8.3;


// Making it to use our contract to create & interact and more with it
contract CampaignFactory is OpenFunds{
// CRUD Events
    event Cancel(uint id);
    event Pledge(uint indexed id,address indexed caller, uint amount);
    event Refund(uint indexed _id,address indexed caller,uint amount);
    event Unpledge(uint indexed id,address indexed caller, uint amount);
    event Launch(
        uint id, 
        address indexed creator,
        uint _goal,
        uint32 _startAt,
        uint32 _endAt
    );
    struct Campaign {
        address creator;
        uint goal;
        uint pledged;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }
    uint public count;
    // mapping count indexes to Campaign
    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public pledgeAmount;
    
    IERC20 public immutable token;
// making IERC20 frame for each Campaigns
    constructor(address _token) OpenFunds(333,0)  {
        token = IERC20(_token);
    }
    function launch(
        uint _goal,
        uint32 _startAt,
        uint32 _endAt
    ) external { 
        require(_startAt >= block.timestamp,"Its a wrong number ");
        require(_endAt >= _startAt, "It will end at its endDate ");
        require(_endAt <= block.timestamp + 90 days,"It should be aleast 3 months");
        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt, 
            endAt: _endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }
    
    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(msg.sender == campaign.creator,'not stared');
        require(block.timestamp < campaign.startAt,"started the Fund-Campaign");
        delete campaigns[_id];
        emit Cancel(_id);
     }
    function pledge(uint _id,uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, 'Not started yet');
        require(block.timestamp <= campaign.endAt,'Aleady ended');

        campaign.pledged += _amount;
        pledgeAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);

        emit Pledge(_id, msg.sender, _amount);
     }
    function unpledge(uint _id,uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt,'ended');

        campaign.pledged -= _amount;
        pledgeAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);
     }
    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator,'Campaign not created');
        require(block.timestamp > campaign.endAt, 'not ended');
        require(campaign.pledged >= campaign.goal, 'pledged < goal');
        require(!campaign.claimed,'claimed');

        campaign.claimed = true;
     }

    function refund(uint _id) external { 
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, 'not ended');
        require(campaign.pledged < campaign.goal, 'pledged < goal');
        
        uint ballance = pledgeAmount[_id][msg.sender];
        pledgeAmount[_id][msg.sender] =0;
        token.transfer(msg.sender, ballance);

        emit Refund(_id, msg.sender, ballance);
    }
    // Creating a event so we can get the address and store it in a Array
    
    function getCampaign() public view returns (address[] memory) {
       
    }
}
