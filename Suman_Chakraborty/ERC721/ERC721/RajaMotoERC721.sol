// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;


contract RajaMotoERC721 {

    mapping (address => uint256) internal balances;
    mapping (uint256 => address) internal owners;
    mapping (address => mapping (address => bool)) private operatorApprovals;
    mapping (uint256 => address) private approvals;

    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    event Approval(address owner, address approver, uint256 tokenId);
    event Transfer (address indexed from, address indexed to, uint256 tokenId);

    function balanceOf(address _owner) public view returns (uint256){
        require(_owner != address(0), "Address is Zero");
        return balances[_owner];
    }

    function ownerOf( uint256 _tokenId) public view returns (address){
        address owner = owners[_tokenId]; 
        require(owner != address(0), "TokenId does not exist");
        return owner;
    }

    function setApprovalForAll(address _operator, bool _approved) public {
        operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool){
        return operatorApprovals[_owner][_operator];
    }

    function approve(address _to, uint256 _tokenId) public{
        address owner = ownerOf(_tokenId);

        require(msg.sender == owner || 
                    isApprovedForAll(owner, msg.sender), 
                    "msg.sender is not the current owner or operator"
                );

        approvals[_tokenId] = _to;

        emit Approval(owner, _to, _tokenId);
    }

    function getApproved(uint256 _tokenId) public view returns(address){
        require(owners[_tokenId] != address(0), "Token Id does not exist");
        return approvals[_tokenId];
    } 

    function transferFrom (address _from, address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);

        require(msg.sender == owner || 
                    getApproved(_tokenId) == msg.sender || 
                    isApprovedForAll(owner, msg.sender), 
                    "msg.sender is not the owner of the operator or the approved address"
                );

        require(_from == owner, "From is not the owner");

        require(_to != address(0), "To can not be zero address");

        require(owners[_tokenId] != address(0), "Token Id does not exist");

        approve(address(0), _tokenId);

        balances[_from] -= 1;
        balances[_to] += 1;
        owners[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function checkOnERC721Received() private pure returns(bool){
        return true;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public {
        transferFrom(_from, _to, _tokenId);
        require(checkOnERC721Received(), "Receiver has not implemented");
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
        require(checkOnERC721Received(), "Receiver has not implemented");
    }

    function supportsInterface(bytes4 interfaceID) view external returns (bool){
        return interfaceID == 0x80ac58cd;
    }
}