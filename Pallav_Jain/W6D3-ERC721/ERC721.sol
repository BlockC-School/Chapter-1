pragma solidity ^0.8.11;

contract ERC721 {
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operaterApprovals;
    mapping(uint256 => address) private _approvals;

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event Approval(address indexed _owner, address indexed _approver, uint256 indexed _tokenId);
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);


	 function balanceOf(address _owner) public view returns (uint256) {
         require(_owner != address(0), "Address is Zero");
         return _balances[_owner];
     }

     function ownerOf(uint256 _tokenId) public view returns (address) {
         address owner = _owners[_tokenId];
         require(owner != address(0), "tokenId is Zero");
         return owner;
     }

     function setApprovalForAll(address _operator, bool _approved) public {
         _operaterApprovals[msg.sender][_operator] = _approved;
         emit ApprovalForAll(msg.sender, _operator, _approved);
     }

     function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return _operaterApprovals[_owner][_operator];
     }

     function approve(address to, uint256 tokenId) public {
         address owner = ownerOf(tokenId);
         require (msg.sender == owner || isApprovedForAll(owner, msg.sender), "msg.sender is not the current owner or operator");
         _approvals[tokenId] = to;

         emit Approval(owner, to, tokenId);
     }

     function getApproved(uint256 _tokenId) public view returns (address) {
         require(_owners[_tokenId] != address(0), "Token id does't Exist");
         return _approvals[_tokenId];
     }

     function transferFrom(address _from, address _to, uint256 _tokenId) public {
         address owner = ownerOf(_tokenId);
         require(msg.sender == owner || getApproved(_tokenId) == msg.sender || isApprovedForAll(owner, msg.sender), "msg.sender is not owner of the operator or the approve address");
         require(_from == owner, "From is not the owner");
         require(_to != address(0), "TO cannot be address zero");
         require(_owners[_tokenId] != address(0), "Token id does not Exists");

         approve(address(0), _tokenId);

         _balances[_from] -= 1;
         _balances[_to] += 1;
         _owners[_tokenId] = _to;

         emit Transfer(_from, _to, _tokenId);
     }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public {
        transferFrom(_from, _to, _tokenId);
        require(_checkOnERC721Recieved(), "Reciever has not Implementer");
    }

    function _checkOnERC721Recieved() private pure returns(bool) {
        return true;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
		return interfaceId == 0x80ac58cd;
    }
}