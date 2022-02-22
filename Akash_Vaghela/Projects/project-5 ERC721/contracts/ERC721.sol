//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.6;

contract ERC721 {

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _approvals;

    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    event Approval(address indexed _owner, address indexed _approver, uint256 _tokenId);
    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Address is zero");
        return _balances[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _owners[_tokenId];
        require(owner != address(0), "TokenId does not exist");
        return owner;
    }
    
    function setApprovalForAll(address _operator, bool _approved) public {
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovalForAll(address _owner, address _operator) public view returns(bool) {
        return _operatorApprovals[_owner][_operator];
    }

    function approve(address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);

        require(msg.sender == owner || isApprovalForAll(owner, msg.sender), "msg.sender is not the current owner of operator");
        _approvals[_tokenId] = _to;

        emit Approval(owner, _to, _tokenId);
    } 

    function getApproved(uint256 _tokenId) public view  returns (address) {
        require(_owners[_tokenId] != address(0), "Token ID does not exist");
        return _approvals[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);

        require(
            msg.sender == owner ||
            getApproved(_tokenId) == msg.sender ||
            isApprovalForAll(owner, msg.sender),
            "msg.sender is not owner or the approved address"
        );
        require(_from == owner, "from is not the owner");
        require(_to != address(0), "to can not be zero address");
        require(_owners[_tokenId] != address(0), "Token ID does not exist");

        approve(address(0), _tokenId);
        _balances[_from] -= 1;
        _balances[_to] += 1;
        _owners[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public {
        transferFrom(_from, _to, _tokenId);
        require(_checkOnERC721Recieved(), "Reciver has not implemented");
    }

    function _checkOnERC721Recieved() private pure returns(bool) {
        return true;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    function supportsInterface(bytes4 _interfaceId) public pure virtual returns(bool) {
		return _interfaceId == 0x80ac58cd;
}
}