// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.2;
import "./@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./@openzeppelin/contracts/access/Ownable.sol";
import "./@openzeppelin/contracts/utils/Strings.sol";


contract Nft_vMint is ERC1155 ,Ownable {
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
    // Events 
    event _ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved); 
    event TransferOnly(address indexed operator, address indexed from, address indexed to, uint256 tokenId, uint256 value);
    
    // we use Arrays of ID and Amount to send So it reduce the gas fees with single transaction_request
    event safeTransferBatch(address indexed operator,address indexed from,address indexed to,uint256[] ids,uint256[] values);
    
    // mapping from accounts to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;
   
    // TokenId => Address => Amount
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // amount => Quantity of nft to be minted 
    function mint(uint256 amount) public onlyOwner {
        tokenCounter += 1;
        _mint(msg.sender, tokenCounter,amount, " ");
    }
    // Contract address rinkbey or any ...
    function uri(uint256 tokenId) override public view returns(string memory) {
        return string (
            abi.encodePacked(
                baseUri, // link of where Data is uploded on ipfs
                Strings.toString(tokenId), // Address of contract when deployed
                ".json" // metaData files number 
            )
        );
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
    // the checking function that returns trnsfer is received or not
    function _checkOnERC1155Recieved() internal pure returns(bool) {
        return true;        
    }
    // Batch transfer function
    function safeBatchTransferFrom(address from, address to, uint256[] memory tokenId, uint256[] memory amount) internal {
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not allow, not an owner and not an approval or operator");
        require(to != address(0), "Invalid address To is '0' ");
        require(amount.length == tokenId.length);
        for(uint256 i = 0; i >= tokenId.length; i++) {
            uint256 Id = tokenId[i]; // we declare a instance to store arrays 
            uint256 _amount = amount[i]; // """""""""""
            SafeTransferFrom(from ,to, Id, _amount); // So we can import here otherwise it will give ~ from uint256[] memory to uint256 requested.
        }
        emit TransferBatch(msg.sender, from, to, tokenId, amount);

        require(_checkOnERC1155Recieved(), 'not implemented OR valid');
    }

    // Authenticity of ERC115 Interface function
    function supportsInterface(bytes4 interfaceID) override public pure returns (bool){
            // return interfaceId == 0x80ac58cd; // this the Id of ERC`1155 
            return interfaceID == 0xd9b67a26 || interfaceID == 0x0e89341c;
            
    }
}