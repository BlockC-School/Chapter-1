// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./ERC721.sol";

// Here Opensea link of DBZ Collection NFT

// https://testnets.opensea.io/assets/0xc1a4ce8241943586c4715056432bd6caaf80de2c/1/

// Contract address rinkbey test n/w : 0xc1a4ce8241943586c4715056432bd6caaf80de2c

contract DBZERC721 is ERC721 {

    string public name;
    string public symbol;
    uint public tokenCount;
    mapping(uint => string) private _tokenUris;

    constructor(string memory _name, string memory _symbol) {
        name  = _name;
        symbol = _symbol;
    }
    function tokenURI(uint tokenId) public view returns(string memory) {
        require(_owners[tokenId] != address(0), "Token Id Does Not Exist");
        return _tokenUris[tokenId];
    }

    function mint(string memory tokenUri) public {
        tokenCount += 1;
        _tokenUris[tokenCount] = tokenUri;
        _balances[msg.sender] = _balances[msg.sender] + 1;
        _owners[tokenCount] = msg.sender;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    function supportsInterface(bytes4 interfaceID)public pure override returns(bool){
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;
    }
}