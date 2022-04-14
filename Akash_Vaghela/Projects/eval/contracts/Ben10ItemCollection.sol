//SPDX-License-Identifier: Unlicense

// deployed on0x327dc4C6A039B6393c9dBD727CdE53683B740c0C

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Ben10ItemCollection is ERC1155, Ownable {
    string public name;
    string public symbol;
    string public baseUri;
    uint256 public tokenCounter;

    constructor (string memory _name, string memory _symbol, string memory _baseUri) ERC1155(_baseUri){
        name = _name;
        symbol = _symbol;
        baseUri = _baseUri;
    }

    function mint(uint256 amount) public onlyOwner {
        tokenCounter += 1;
        _mint(msg.sender, tokenCounter, amount, "");
    }

    function uri(uint256 _tokenId) override public view returns(string memory) {
        return string (
            abi.encodePacked(baseUri, Strings.toString(_tokenId), ".json")
        );
    }
}
