// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Multisig {
    address[] public approvers;
    uint public threshold;

    struct Transfer{
        uint id;
        uint amount;
        address payable to;
        uint approvals;
        bool sent;
    }

    mapping(uint => Transfer) transfers;
    mapping(address => mapping(uint => bool)) approvals;


    uint nextId;

    constructor(address[] memory _approvers, uint _threshold) public payable {
        approvers = _approvers;
        threshold = _threshold;
    }

    modifier onlyApprover() {
        bool allowed = false;

        for(uint i=0; i < approvers.length ; i++) {
            if(approvers[i] == msg.sender) {
                allowed = true;
            }
        }
        require(allowed == true, "Not the owner own the safe");
        _;
    }
    
    function createTransaction(
			address payable to, 
			uint amount
		) external onlyApprover returns(uint){
        transfers[nextId] = Transfer(nextId, amount, to, 0, false);
        nextId++;
        return nextId - 1;
    }

    function sendTransfer(uint id) external onlyApprover {
        require(transfers[id].sent == false, "Transfer already sent");
        require(transfers[id].approvals >= threshold, 
										"Transaction require approvals");

        transfers[id].sent = true;
        uint amount = transfers[id].amount;
        address payable to = transfers[id].to;

        to.transfer(amount);
        return;
    }

    function addApprover(uint id) external onlyApprover {
        if(approvals[msg.sender][id] == false) {
            approvals[msg.sender][id] = true;
            transfers[id].approvals++;
        }
    }
}