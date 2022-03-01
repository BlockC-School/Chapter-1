// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "./RajaMotoERC721.sol";

contract RajaMotoERC721Collection is RajaMotoERC721{
    string public name;
    string public symbol;
    uint256 public tokenCounter;
    mapping (uint256 => string) private tokenURIs;

    constructor (string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory){
        require(ownerOf(_tokenId) != address(0), "TokenID does not exist");
        return tokenURIs[_tokenId];
    }

    function mint (string memory _tokenURI) public {
        tokenCounter += 1;
        balances[msg.sender] = balances[msg.sender] + 1;
        owners[tokenCounter] = msg.sender;
        tokenURIs[tokenCounter] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCounter);
    }

    // Confirm support that Your contract had interface ERC721 & ERC721Metadata
    function supportsInterface(bytes4 interfaceID)public pure override returns(bool){
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;
    }
}