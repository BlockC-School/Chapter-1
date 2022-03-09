// SPDX-License-Identifier: MIT

import "../Crowd-funding/node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity >=0.8.6;

contract OpenFund is ERC721{
    // Events of Crowdfund Logic
    event ProjectCreated(string proposalId, string name, string description, uint256 fundsGoal);
    event ProjectFunded(string proposalId, uint256 value);
    event ProjectStateChanged(uint256 id, CurrentState state);

    // mapping from accounts to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    // TokenId => Address => Amount
    mapping(uint256 => mapping(address => uint256)) private _balances;    
    address public owner;
    modifier onlyOwner(){
        require(owner == msg.sender,"you are not registered");
        _;
    }
   
    // amount => Quantity of FakeAmount to be minted 
    // function mint(uint256 amount) public onlyOwner {
    //     tokenCounter += 1;
    //     _mint(msg.sender, tokenCounter);
    // }
    
    // string public name;
    string public Kindpurpose;
    uint256 public tokenCounter;
    string public baseUri;
    uint256 public fundGoal;

    constructor (
        string memory _purpose, string memory _baseUri, uint256 _fundGoal 
    ) ERC721 ("name", "Dofo") {
        // name = _name;
        Kindpurpose = _purpose;
        baseUri = _baseUri; // link of any Data metaData uploded on web OR ipfs /containg Proposal Details
        fundGoal = _fundGoal;
    }
    // States for the transaction
    enum CurrentState {
        Opened,
        Closed
    }
    // Contribution details
    struct Contribution{
        address contributer;
        uint256 value;
    }
    mapping(string => Contribution[]) public contributions;
    // Fund details Object
    struct Project {
        string proposalId;
        string name;
        string desciption;
        address payable owner;
        CurrentState state;
        uint256 fund;
        uint256 fundGoal;
    }  
    Project[] public projects;

    modifier isOwner(uint256 _projectIndex){
        require(projects[_projectIndex].owner == msg.sender, "Not a contributer"); 
        _;
    }

    // Creating the project proposal
    function CreateProject(
        string memory  _Id,
        string calldata _name,
        string calldata _description,
        uint256 _fundGoal
    ) public {
        require(_fundGoal > 0,"0 is not valid");
        Project memory project = Project(
            _Id,
            _name,
            _description,
            payable(msg.sender),
            CurrentState.Opened,
            0,
            _fundGoal
        );
        // Project Created and pushed 
        projects.push(project);
        emit ProjectCreated(_Id, _name, _description, _fundGoal);
    }
    // For restriction user can not fund their own 
    modifier isNotOwner(uint256 proposalId) {  
        require(projects[proposalId].owner != msg.sender,
                "As owner you cannot fund to self" );
            _;
        }
    // Fund project 
    function FundProject(uint256 projectId) public payable isNotOwner(projectId) 
      {
        Project memory project = projects[projectId];
        require(project.state != CurrentState.Closed," Project cannot recieve funds it is closed");
        require(msg.value > 0," value cannot be 0");
        project.owner.transfer(msg.value); 
        project.fund += msg.value;
        projects[projectId] = project;
// Contribute and emit the funds
        contributions[project.proposalId].push(Contribution(msg.sender, msg.value));
    // releasing the fund into project
        emit ProjectFunded(project.proposalId, msg.value);    
    }
// Changing current state    
    function ChangeState(CurrentState _newState,uint256 projectId) public isOwner(projectId) {
        Project memory project = projects[projectId];
        require(project.state != _newState,"already changed");
        project.state = _newState;
        projects[projectId] = project;
        // emiting changes
        emit ProjectStateChanged(projectId, _newState);
    }

    // the checking function that returns trnsfer is received or not
    function _checkOnERC1155Recieved() internal pure returns(bool) {
        return true;        
    }
    // Authenticity of ERC115 Interface function
    function supportsInterface(bytes4 interfaceID) override public pure returns (bool){
            // return interfaceId == 0x80ac58cd; // this the Id of ERC`1155 
            return interfaceID == 0xd9b67a26 || interfaceID == 0x0e89341c;
            
    }
}

