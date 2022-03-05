// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERCInterface1155{

    //TokenId => Address => How many TokenId
    mapping (uint256 => mapping(address => uint256)) internal balances;

    //Account(address) => operator(address) => bool(true/false)
    mapping(address => mapping(address => bool)) private operatorApprovals;

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _isApproved);
    event TransferSingle(address _owner, address indexed _from, address indexed _to, uint256 _tokenId, uint256 _amount);
    event TransferBatch(address _owner, address indexed _from, address indexed _to, uint256[] _tokenIds, uint256[] _amounts);

    // Returns the balance (how many token is present for a particular tokenId for a specific address) of the perticular account
    function balanceOf(address _account, uint _tokenId) public view returns (uint256){
        require(_account != address(0), "Address is Zero");
        return balances[_tokenId][_account];
    }

    //Returns the batch balance of the account
    function balanceOfBatch(address [] memory _accounts, uint256 [] memory _tokenIds) public view returns(uint256 [] memory){
        require(_accounts.length == _tokenIds.length, "Accounts and Tokens must be in same amount");

        uint256[] memory batchBalances = new uint256[](_accounts.length);

        for(uint256 i=0; i<_accounts.length; i++){
            batchBalances[i] = balanceOf(_accounts[i], _tokenIds[i]);
        }

        return batchBalances;
    }

    //Check for the operator Approvals
    function isApprovedForAll(address _account, address _operator) public view returns (bool){
        return operatorApprovals[_account][_operator];
    }

    //Enable or disable the operator for an specific account
    function setApprovalForAll(address _operator, bool _isApproved) public {
        require(msg.sender != address(0) && _operator != address(0), "Account and Operator should be addresses");
        operatorApprovals[msg.sender][_operator] = _isApproved;
        emit ApprovalForAll(msg.sender, _operator, _isApproved);
    }

    function _transfer(address _from, address _to, uint256 _tokenId, uint256 _amount) private {
        uint256 fromBalance = balances[_tokenId][_from];
        require(fromBalance >= _amount, "Insufficient Balance");
        balances[_tokenId][_from] -= _amount;
        balances[_tokenId][_to] += _amount;
    }

    //Weather the NFT is being sent to any contract not any EOA account.
    function _checkOnERC721Received() private pure returns(bool){
        return true;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, uint256 _amount) public virtual{
        require(_from == msg.sender || isApprovedForAll(_from, msg.sender), "Msg.sender is not owner or not operator");
        require(_to != address(0), "Address is zero");

        _transfer(_from, _to, _tokenId, _amount);

        emit TransferSingle(msg.sender, _from, _to, _tokenId, _amount);

        require(_checkOnERC721Received(), "Receiver is not implemented");
    }


    //Weather the NFT is being sent to any contract not any EOA account.
    function _checkOnERC721BatchReceived() private pure returns(bool){
        return true;
    }

    function safeBatchTransferFrom(address _from, address _to, uint256 [] memory _tokenIds, uint256 [] memory _amounts) public {
        require(_from == msg.sender || isApprovedForAll(_from, msg.sender), "Msg.sender is not owner or not operator");
        require(_to != address(0), "Address is zero");
        require(_tokenIds.length == _amounts.length, "Amounts and Tokens must be in same amount");

        for(uint256 i=0; i<_tokenIds.length; i++){
            uint256 tokenId = _tokenIds[i];
            uint256 amount = _amounts[i];

            _transfer(_from, _to, tokenId, amount);
        }

        emit TransferBatch(msg.sender, _from, _to, _tokenIds, _amounts);
        require(_checkOnERC721BatchReceived(), "Receiver is not implemented for Batch Transfer");

    }

    function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool){
        return interfaceId == 0xd9b67a26;
    }


}