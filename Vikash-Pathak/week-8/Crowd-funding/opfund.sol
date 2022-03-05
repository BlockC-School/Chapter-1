// SPDX-License-Identifier: MIT

import "../Crowd-funding/node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

pragma solidity >=0.8.6;

contract OpenFund is ERC1155{
    // Events of Crowdfund Logic
    event ProjectCreated(uint256 proposalId, string name, string description, uint256 fundsGoal);
    event ProjectFunded(uint256 proposalId, uint256 value);
    event ProjectState(uint256 id, CurrentState state);

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
    function mint(uint256 amount) public onlyOwner {
        tokenCounter += 1;
        _mint(msg.sender, tokenCounter,amount, " ");
    }
    
    string public name;
    string public Kindpurpose;
    uint256 public tokenCounter;
    string public baseUri;
    uint256 public fundGoal;

    constructor (
        string memory _name, string memory _purpose, string memory _baseUri, uint256 _fundGoal 
    ) ERC1155 (_baseUri) {
        name = _name;
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
        uint256 proposalId;
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
    function CreateProject() public {

    }
    // Fund project 
    function FundProject() public {
        
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

