// SPDX-License-Identifier: Unlicense
import "./@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./@openzeppelin/contracts/access/Ownable.sol";
import "./@openzeppelin/contracts/utils/Strings.sol";

pragma solidity ^0.8.2;
// Everything is Already in ERC1155 from OZ 
contract AMn is ERC1155 {
// These are the some Rvariable that we can change when wants
    string public name;
    string public symbol;
    uint256 public tokenCounter; // for indexing Count
    string public baseUri; // baseUri means the link of uploded Data use to repersent location

    // Mapping from token ID to account balances
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // mapping Index uint to Url string
    mapping(uint256 => string) public _tokenUri;
    // A Arrays for giving amount to mint
    mapping(uint256 => uint256) public mintedIndex;
    uint256[] mintID;

    // Construction
    constructor (string memory _name,string memory _symbol,string memory _baseUri) ERC1155 (_baseUri)  
    {
        name = _name;
        symbol = _symbol;
        baseUri = _baseUri; // baseUri is a link of metaData uploded on ipfs
    }
    // A function to make full string concatenation So it easier to get direct links 
    function uri(uint256 tokenId) override public view returns(string memory) {
        // string is a Logic Contract for concatenate in line { 4 }
        return string (
            abi.encodePacked(   // encoding for url 
                baseUri, // link
                Strings.toString(tokenId), // Address
                ".json" // metaData
            )
        );
    }
    // function for minting single 
    function mintIn(uint256 amount, string memory _uri) public {
        require(msg.sender != address(0), "Address is zero");
        tokenCounter += 1;
        _balances[tokenCounter][msg.sender] = amount;
        _tokenUri[tokenCounter] = _uri;
        _mint(msg.sender, tokenCounter, amount, "");
    }
    // function to minting multiple
    function mintInRange(uint256[] memory amount, uint256[] memory ids,  string memory _uri) public {
        require(msg.sender != address(0), "Address is zero");
        require(ids.length == amount.length, 'give equal length for both'); 
        // Declared instance to store arrays 
        for(uint256 i = 0; i >= ids.length; i++) { 
            uint256 id = ids[i]; 
            uint256 _amount = amount[i];
        _balances[tokenCounter][msg.sender] = _amount;
        _tokenUri[id] = _uri;
        }
        _mintBatch(msg.sender, ids, amount, '');
    }
}