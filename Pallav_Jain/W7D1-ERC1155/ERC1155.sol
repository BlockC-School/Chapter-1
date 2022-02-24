// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract ERC1155 {
    //tokenID => address => ammount
    mapping(uint256 => mapping(address => uint256)) internal _balances;
    //account -> Operator Address -> isEnabled;
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    event ApprovalForAll(address indexed _owner, address indexed Operator, bool approved);
    event transferSingle(address operator,address indexed from, address indexed to, uint256 indexed tokenID, uint256 ammount);
    event transferBatch(address operator,address indexed from, address indexed to, uint256[] indexed tokenIDs, uint256[] ammounts);

    function balanceOf(address account, uint256 _tokenID) public view returns(uint256) {
        require(account == address(0), "Addrss is Zero");
        return _balances[_tokenID][account];
    }

    //return the balances of accounts
    function balanceOfBatch(address[] memory  accounts, uint256[] memory _tokenIDs) public view returns(uint256[] memory) {
        require(accounts.length == _tokenIDs.length, "Account and ids are not same");
        uint256[] memory batchBalances = new uint256[](accounts.length);

        for(uint256 i = 0; i< accounts.length; i++) {
            batchBalances[i] = balanceOf(accounts[i], _tokenIDs[i]);
        }
        return batchBalances;
    }

    //Check For the operator Approvals
    function isApprovalForAll(address account, address operator) public view returns(bool){
        return _operatorApprovals[account][operator];
    }

    //Enables & Disable the operator for an specific Account
    function seApprovalForAll(address operator, bool approved) public {
        _operatorApprovals[msg.sender][operator] = approved;

        emit ApprovalForAll(msg.sender, operator, approved);
    } 

    function _transfer(address from, address to, uint256 _tokenID, uint256 ammount) private {
        uint256 fromBalances = _balances[_tokenID][from];
        require(fromBalances >=  ammount, "Insufficiant Balance");
        _balances[_tokenID][from] = fromBalances - ammount;
        _balances[_tokenID][to] += ammount;
    }

    function safeTransferFrom(address from, address to, uint256 _tokenID, uint256 ammount) public virtual {
        require(from == msg.sender || isApprovalForAll(from, msg.sender), "msg.sender is not owner or operator");
        require(to != address(0), "Address is Zero");
        _transfer(from, to, _tokenID, ammount);

        emit transferSingle(msg.sender, from, to, _tokenID, ammount);

        require(checkOnERC1155Recieved(), "Reciever is not Inmpimented");
    }

    function checkOnERC1155Recieved() private pure returns(bool) {
        return true;
    }


    function safeBatchTransferFrom(address from, address to, uint256[] memory _tokenIDs, uint256[] memory ammounts) public virtual {
        require(from == msg.sender || isApprovalForAll(from, msg.sender), "msg.sender is not owner or operator");
        require(to != address(0), "Address is Zero");
        require(_tokenIDs.length == ammounts.length, "ids are not the same length of the ammount");

        for(uint256 i=0; i<_tokenIDs.length; i++) {
            uint256 id = _tokenIDs[i];
            uint256 ammount = ammounts[i];

            _transfer(from, to, id, ammount);
        }

        emit transferBatch(msg.sender, from, to, _tokenIDs, ammounts);
        require(checkOnBatchERC1155Recieved(), "Reciever is not Inmpimented");
    }

    function checkOnBatchERC1155Recieved() private pure returns(bool) {
        return true;
    }

    function supportsInterface(bytes4 interfaceId) public pure returns(bool) {
		return interfaceId == 0xd9b67a26;
	}
}