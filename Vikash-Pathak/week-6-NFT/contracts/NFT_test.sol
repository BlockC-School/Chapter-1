// SPDX-License-Identifier: MIT
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.0;

contract NFT_TNT is ERC721 {
    
    uint256 public TokenCounter; // Creating For Count transfers

    constructor() ERC721("MyNFT","MNFT"){
        TokenCounter = 0;
    }

    function createCollectible(string memory TokenURI) public returns (uint) {
        uint256 tokenID = TokenCounter;
        _safeMint(msg.sender, tokenID);
        tokenURI(tokenID);
        TokenCounter = TokenCounter + 1;
    }
}