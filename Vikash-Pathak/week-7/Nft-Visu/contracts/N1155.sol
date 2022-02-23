// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.2;
import "../node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";

contract Nft_v is ERC1155 ,Ownable {
    string public name;
    string public symbol;
    uint256 public tokenCounter;
    string public baseUri;
    constructor (
        string memory _name, string memory _symbol, string memory _baseUri
    ) ERC1155 (_baseUri) {
        name = _name;
        symbol = _symbol;
        baseUri = _baseUri;
    }
    function mint(uint256 amount) public onlyOwner {
        tokenCounter += 1;
        _mint(msg.sender, tokenCounter,amount, " ");
    }
    function uri(uint256 tokenId) override public view returns(string memory) {

    }
}