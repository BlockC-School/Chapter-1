// SPDX-License-Identifier: MIT
 
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity >=0.4.0 <0.9.0;

contract BigBlue is ERC721, ERC721Enumerable, ERC721URIStorage {
    using SafeMath for uint256;
    uint public constant mintPrice = 0.06 ether;
    bool public isMintable;
    // uint256 public maxSupply;
    // uint256 public TotalSupply;
    
    mapping(uint256 => string) private _tokenURI;
    mapping(address => uint256) public mintedWallets;

    constructor () ERC721("BlueBird", "BB") { }
    function mint(string memory _URI) public payable {
        require(isMintable == false, "mint is not enable");
        require(mintedWallets[msg.sender] < 1, "only one per wallet");
        require(msg.value == mintPrice, "minting price is 0.06");
        // require(maxSupply >= TotalSupply, "out of stock");

        uint256 mintIndex = totalSupply();
        _safeMint(msg.sender, mintIndex);
        _setTokenURI(mintIndex, _URI);
    }
    function ToggleIsEnable() external  {
        isMintable = !isMintable;
    }
    // function setMaxSupply(uint256 maxSupply_) external  {
    //     maxSupply = maxSupply_;
    // }
    function _beforeTokenTransfer(address _from, address _to, uint _tokenId) internal override (ERC721, ERC721Enumerable) {
       require(_to != address(0));
       require(_from != address(0));
       require(_to != _from);
        super._beforeTokenTransfer(_from, _to, _tokenId);
    }

    function _burn(uint _tokenId) internal override (ERC721,ERC721URIStorage ) {
        super._burn(_tokenId);
    }
    function tokenURI(uint _tokenId) public view override (ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(_tokenId);
    }
    function supportsInterface(bytes4 _interfaceID) public view override (ERC721Enumerable,ERC721) returns (bool) {
        return super.supportsInterface(_interfaceID);
    }
    
}