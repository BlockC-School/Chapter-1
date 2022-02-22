// SPDX-License-Identifier: Unlicense OR MIT
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
pragma solidity >=0.4.11;

contract ERC721 {
	// returns the balance of the ethereum address
	mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
	mapping(address => mapping(address => bool)) private _operatorApprovals;
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
	
    function balanceOf(address _owner) public view returns(uint256) {
		// require(_owner != address(0), "Address is zero");
		// return _balances[_owner];
	}
	// return the owner address of the NFT
	function ownerOf(uint256 tokenId) public view returns(address) {
		// address owner = _owners[tokenId];
		// require(owner != address(0), "TokenId does not exist");
		// return owner;
	}
	// enables or disabled an operator to manage all of msg.sender assets
	function setApprovalForAll(address _operator, bool approved) public view returns(address) {
		// _operatorApprovals[msg.sender][_operator] = approved;
		// emit ApprovalForAll(msg.sender, _operator, approved);
	}

	function isApprovedForAll(address _owner, address operator) public view returns(bool) {
		// return _operatorApprovals[_owner][operator];
	}
    function getApproved(uint256 tokenId) public view returns(address) {
        // return ;
    }
    function approve(address _to, uint256 _tokenId) public returns(bool) {
        // require(msg.sender != address(0), "Address is zero");
        // require(_to != address(0), "Address is zero");
        // require(_tokenId != 0, "TokenId is zero");
        // require(ownerOf(_tokenId) == msg.sender, "Only the owner can approve");
        // _operatorApprovals[msg.sender][_to] = true;
        // // emit ApprovalForAll(msg.sender, _to, true);
        // return true;
    }
	// transfer Ownership of an nft
	function transferFrom(address from, address to, uint256 tokenId) public {
		// address owner = ownerOf(tokenId);
		// require(
		// 	msg.sender == owner ||
		// 	getApproved(tokenId) == msg.sender ||
		// 	isApprovedForAll(owner, msg.sender),
		// 	"msg.sender is not owner or approved for transfer"
		// );

		// require(owner == from, "From address is not the owner");
		// require(to == address(0), "to address cannot be zero address");
		// require(_owners[tokenId] != address(0), "TokenId Does not exist");

		// approve(address(0), tokenId);
	
		// _balances[from] -= 1;
		// _balances[to] += 1;
		// _owners[tokenId] = to;
	
		// emit Transfer(from, to, tokenId);
	}
	
	// Similar to standard form
	function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
		// transferFrom(from, to, tokenId);
		// require(_checkOnERC721Recieved(), "Reciever not implemented");
	}	
	function _checkOnERC721Recieved() private pure returns(bool) {
			// return true;
	}
    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
		// return interfaceId == 0x80ac58cd;
}
}