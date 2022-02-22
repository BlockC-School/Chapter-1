pragma solidity ^0.8.11; 
import "./ERC721.sol";

contract Marvel is ERC721 {
    string public name;
    string public symbol;
    uint256 public tokenCounter;
    // Mapping to store the tokenUri
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    }

    // Function to get the tokenUri of any TokenId
    function tokenURI(uint256 _tokenId) external view returns (string memory){
        require(ownerOf(_tokenId) != address(0), "Token ID is not Valid");
        return _tokenURIs[_tokenId];
    }

    // Creates a new nft to the collection
    function mint(string memory tokenUri) public {
        tokenCounter += 1;
        _balances[msg.sender] = _balances[msg.sender] + 1;
        _owners[tokenCounter] = msg.sender;
        _tokenURIs[tokenCounter] = tokenUri;

        emit Transfer(address(0), msg.sender, tokenCounter);
    }

    // Confirm support that Your contract had interface ERC721 & ERC721Metadata
    function supportsInterface(bytes4 interfaceID)public pure override returns(bool){
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;
    }
}