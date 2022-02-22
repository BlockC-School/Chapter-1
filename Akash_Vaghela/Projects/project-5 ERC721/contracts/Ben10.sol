//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.6;
import "./ERC721.sol";

contract Ben10 is ERC721 {

    string public name;
    string public symbol;
    uint256 public tokenCounter;
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory){
        require(ownerOf(_tokenId) != address(0), "token id is not valid");
        return _tokenURIs[_tokenId];
    }

    function mint(string memory _tokenURI) public {
        tokenCounter += 1;
        _balances[msg.sender] = _balances[msg.sender] + 1;
        _owners[tokenCounter] = msg.sender;
        _tokenURIs[tokenCounter] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCounter);
    }
    
    function supportsInterface(bytes4 _interfaceId) public pure override virtual returns (bool) {
        return _interfaceId == 0x80ac58cd || _interfaceId == 0x5b5e139f;
    }
}