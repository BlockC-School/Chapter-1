// SPDX-License-Identifier: Unlicense
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
// import "./node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "./ERC1155/ERC1155.sol";
                                
// import * as ERC1155 from "../ERC1155--/contracts/token/ERC1155/ERC1155.sol"; // "../contracts/token/ERC1155/ERC1155.sol";
import "./copy_contracts/token/ERC1155/ERC1155.sol";
import "./copy_contracts/access/Ownable.sol";
import "./copy_contracts/utils/Strings.sol";
pragma solidity ^0.8.2;
// This contract have some extra features than ERC721 
contract MyProCon is ERC1155 {
    //{balanceOf functions} 1 balanceOf // 2 balanceOfBatch
    //{operator functions} 1 isApprovedForAll // 2 setApprovalForAll
    // {transfers functiom} 1 safeTransferFrom // 2 safeBatchTransferFrom
    // {interface functions} 1 supportsInterface
// *******          ****************************            *********

    // events 
    event _ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved); 
    event TransferOnly(address indexed operator, address indexed from, address indexed to, uint256 tokenId, uint256 value);
    // mapping from accounts to operator approvals
    // Account => Operators Address => Approvals Bool State 
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    // mapping tokenIds to balanceOf those ids
    // TokenId => Address => Amount
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // Without constructor contract should give abstract error
    string public name;
    string public symbol;
    uint256 public tokenCounter;
    string public baseUri;
    constructor (
        string memory _name, string memory _symbol, string memory _baseUri 
    ) ERC1155 (_baseUri) {
        name = _name;
        symbol = _symbol;
        baseUri = _baseUri; // baseUri is a link of metaData uploded on ipfs
    }
    // this function returns balanceOf One account & id
    function balanceOf(address account, uint256 id) override public view returns ( uint256 ) {
        require(account != address(0), 'not valid account'); // Account have to be a Owned address
        return _balances[id][account];
    }
    // this function returns balanceOf multiple accounts  &  ids
    function balanceOfBatch(address[] memory account, uint256[] memory id) override public view returns (uint256[] memory) {
        require(msg.sender != address(0), 'not valid account');
        // created a Var to track accounts length
        uint256[] memory batchBalances = new uint256[](account.length);
        for(uint256 i = 0; i < account.length; i++) {
            batchBalances[i] = balanceOf(account[i], id[i]);
        }
        return batchBalances;
    }
    // check Operators BooleanSlot setting : functions
    function isApprovedForAll(address account, address operator) public override view returns (bool){
        return _operatorApprovals[account][operator];
    }
    // Setting for approvals for all 
    function setApprovalForAll(address operator,bool approved) override public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
    // transfer fucntion
    function transfer(address from, address to, uint256 tokenId,uint256 amount) private {
        uint256 fromBalance = _balances[tokenId][from];
        require(fromBalance >= amount, "Not enough Amount");
        _balances[tokenId][from] = fromBalance - amount;
        _balances[tokenId][to] += amount; 
    }
    // SafeTransferFrom is the best and Secure to use instead of transfer functions
    function SafeTransferFrom(address  from, address  _to, uint256 _tokenId, uint256 _amount) private  {
            // this have more robost logic
            require(from == msg.sender || isApprovedForAll(from, msg.sender), 'Not a owner & operator ');
            require(_to != address(0), 'not valid account');
            require(from != address(0), 'not valid account');
            emit TransferOnly(msg.sender, from, _to, _tokenId, _amount);

    }
}


