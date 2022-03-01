// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ERC1155.sol";

contract MarvelERC1155 is ERC1155 {
    string public name;
    string public symbol;
    uint256 public tokenCount;
    // Mapping to store the tokenUri
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    }

    // Function to get the tokenUri of any TokenId
    function tokenURI(uint256 _tokenId) external view returns (string memory){
        // require(ownerOf(_tokenId) != address(0), "Token ID is not Valid");
        return _tokenURIs[_tokenId];
    }

    // Creates a new nft to the collection
    function mint(uint256 ammount, string memory uri) public {
        require(msg.sender != address(0), "Addres should not be Zero");
        tokenCount += 1;
        _balances[tokenCount][msg.sender] = ammount;
        _tokenURIs[tokenCount] = uri;       

        emit transferSingle(msg.sender, address(0), msg.sender, tokenCount, ammount);
    }

    // Confirm support that Your contract had interface ERC721 & ERC721Metadata
    function supportsInterface(bytes4 interfaceID)public pure override returns(bool){
        return interfaceID == 0xd9b67a26 || interfaceID == 0x0e89341c;
    }
}