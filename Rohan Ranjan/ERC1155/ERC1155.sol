// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract ERC1155 {

    // event
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event TransferSingle(address indexed _operator, address _from, address indexed _to, uint indexed _tokenId, uint _value);
    event TransferBatch(address indexed _operator, address _from, address indexed _to, uint[] indexed _tokenIds, uint[] _values);
    // Mapping from TokenId to account Balances
    // TokenId => Address => Amount
	mapping(uint => mapping(address => uint)) internal _balances;

    // Accound => Operator Address => isEnableOrNot
    mapping(address => mapping(address => bool)) _operatorApprovals;

    // Gets the balance of an accounts token
	function balanceOf(address account, uint256 id) public view returns(uint){
		require(account != address(0), "Address is zero");
		return _balances[id][account];
	}
    // Gets the balance of multiple accounts token
	function balanceOfBatch(address[] memory _accounts, uint[] memory _tokenIds) public view returns(uint[] memory){
        require(_accounts.length == _tokenIds.length, "Accound and Ids are not matching");
		uint[] memory batchBalances = new uint[](_accounts.length);
		for(uint i = 0; i < _accounts.length; i++) {
			batchBalances[i] = balanceOf(_accounts[i], _tokenIds[i]);
		}
		
		return batchBalances;
	}

    // check for operator approvals
    function isApprovedForAll(address _account, address _operator) public view returns(bool) {
        return _operatorApprovals[_account][_operator];
    }

    // Enables and Disables the operator for an sepcific Account
    function setApprovalForAll(address _operator, bool _approved) public {
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function _transfer(address from, address to, uint tokenId, uint amount) private {
        // first checking balance of from address
        uint fromBalance = _balances[tokenId][from];
        require(fromBalance >= amount, "Insufficent fund");
        _balances[tokenId][from] = fromBalance - amount;
        _balances[tokenId][to] += amount;
    }

    // This function is virtual, because we are going to override in our contract.
    function safeTransferFrom(address from, address to, uint tokenId, uint amount) public virtual {
        // first we need to check from is owner OR approval for that sepecific tokenId.
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not allow, not an owner and not an approval or operator");
        require(to != address(0), "Invalid TO address");
        _transfer(from, to, tokenId, amount);
        emit TransferSingle(msg.sender, from, to, tokenId, amount);
        require(_checkOnERC1155Received(), "Reciever is not implememnted");
    }

    function _checkOnERC1155Received() private pure returns(bool){
		return true;
	}

    function safeBatchTranferFrom(address from, address to, uint[] memory tokenIds, uint[] memory amounts) public virtual {
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not allow, not an owner and not an approval or operator");
        require(to != address(0), "Invalid TO address");
        require(tokenIds.length == amounts.length, "tokenIds and amounts are not matching");

        for(uint i = 0; i < tokenIds.length; i++){
            uint _tokenId = tokenIds[i];
            uint amount = amounts[i];
            _transfer(from, to, _tokenId, amount);
        }

        emit TransferBatch(msg.sender, from, to, tokenIds, amounts);
        require(_checkOnBatchERC1155Received(), "Reciever is not implememnted");
    }

    function _checkOnBatchERC1155Received() private pure returns(bool){
		return true;
	}

    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
		return interfaceId == 0xd9b67a26;
	}
}