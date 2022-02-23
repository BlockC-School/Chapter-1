// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./ERC1155.sol";

// contract address: 0xb00878ca93a34b6da687d5cd43f02563dc80e08a

// opensea link: 

contract DBZGBERC1155 is ERC1155 {

    string public name;
    string public symbol;
    uint public tokenCount;
    mapping(uint => string) _tokenUri;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function uri(uint tokenId) public view returns (string memory){
        return _tokenUri[tokenId];
    }

    function mint(uint amount, string memory _uri) public {
        require(msg.sender != address(0), "Address is zero");
        tokenCount += 1;
        _balances[tokenCount][msg.sender] = amount;
        _tokenUri[tokenCount] = _uri;
        emit TransferSingle(msg.sender, address(0), msg.sender, tokenCount, amount);
    }

    function supportsInterface(bytes4 interfaceId) public pure override returns(bool){
        return interfaceId == 0xd9b67a26 || interfaceId == 0x0e89341c;
    }
}