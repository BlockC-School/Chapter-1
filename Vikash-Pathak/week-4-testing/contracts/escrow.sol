// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./SafeMath.sol";


contract EsFactory {
    Escrow[] public escrows; // Array of escrows
    address[] public allEscrowContracts;  // array of all contracts address
    uint256 public escrowCount;  // number of escrow
    address public factoryOwner; // main owner of factory 
    
    function Factory() public {
        factoryOwner = msg.sender;
        escrowCount = 0;
    }
    
    function createContract() public {
        Escrow newContract = new Escrow(factoryOwner, escrowCount);
        escrows.push(newContract);
    }
    
    function getAllContracts() public view returns (address[] memory) {
        return allEscrowContracts;
    }
    
    function getByID(uint256 queryID) public view returns (address) {
        return allEscrowContracts[queryID];
    }
}
    

contract Escrow {
    mapping (address => uint256) private balances; // mapping the balances of each user to their address

    address payable public user_S; // the address of the seller
    address payable public user_B; // the address of the buyer
    address public escrowOwner; // the address of the escrow owner
    uint256 public blockNumber; // the block number of the transaction

    
    uint public escrowID; // the escrow ID of the transaction

    bool public sellerApproval; // whether the seller has approved the transaction
    bool public buyerApproval; // whether the buyer has approved the transaction 
    
    bool public sellerCancel; // Bool value approvence of the seller
    bool public buyerCancel; // Bool value approvence of the buyer
    
    uint256[] public deposits; // All deposits of the transaction
    
    uint256 public sellerAmount; // Amount on which both agree

   // State for the transaction
    enum EscrowState { unInitialized, initialized, buyerDeposited, TransactionApproved, escrowComplete, escrowCancelled }
    EscrowState public eState = EscrowState.unInitialized; // The first state of the escrow

// Deposit event
    event Deposit(address depositor, uint256 deposited);
    event PaymentTransaction(uint256 blockNo, uint256 contractBalance);

    modifier onlyBuyer() {
        if (msg.sender == user_B) {
            _;
        } else {
            revert();
        }
    }

    modifier onlyEscrowOwner() {
        if (msg.sender == escrowOwner) {
            _;
        } else {
            revert();
        }
    }    

    modifier checkBlockNumber() {
        if (blockNumber > block.number) {
            _;
        } else {
            revert();
        }
    }

    modifier ifApprovedOrCancelled() {
        if ((eState == EscrowState.TransactionApproved) || (eState == EscrowState.escrowCancelled)) {
            _;
        } else {
            revert();
        }
    }

    // function EscrowClone(address payable fOwner, uint256 _escrowID) public {
    //     escrowOwner = fOwner;
    //     escrowID = _escrowID;
    // }
    constructor(address fOwner, uint  _escrowID) payable {
        escrowOwner = fOwner;
        escrowID = _escrowID;
        // carAddr = address(this);
    }

    function initEscrow(address payable _seller, address payable  _buyer, uint256 _blockNum) public onlyEscrowOwner {
        require((_seller != msg.sender) && (_buyer != msg.sender));
        escrowID += 1;
        user_S = _seller;
        user_B = _buyer;
       
        blockNumber = _blockNum;
        eState = EscrowState.initialized;

        balances[user_S] = 0;
        balances[user_B] = 0;
    }

    function depositToEscrow() public payable checkBlockNumber onlyBuyer {
        balances[user_B] = SafeMath.add(balances[user_B], msg.value);
        deposits.push(msg.value);
        eState = EscrowState.buyerDeposited;
        emit Deposit(msg.sender, msg.value); // solhint-disable-line
    }

    function approveEscrow() public {
        if (msg.sender == user_S) {
            sellerApproval = true;
        } else if (msg.sender == user_B) {
            buyerApproval = true;
        }
        if (sellerApproval && buyerApproval) {
            eState = EscrowState.TransactionApproved;
            
            withdraw();
            emit PaymentTransaction(block.number, address(this).balance); 
        }
    }

    function cancelEscrow() public checkBlockNumber {
        if (msg.sender == user_S) {
            sellerCancel = true;
        } else if (msg.sender == user_B) {
            buyerCancel = true;
        }
        if (sellerCancel && buyerCancel) {
            eState = EscrowState.escrowCancelled;
            refund();
        }
    }

    function checkEscrowStatus() public view returns (EscrowState) {
        return eState;
    }
    
    function getEscrowContractAddress() public view returns (address) {
        return address(this);
    }
    
    function getAllDeposits() public view returns (uint256[] memory) {
        return deposits;
    }
    
    function hasBuyerApproved() public view returns (bool) {
        if (buyerApproval) {
            return true;
        } else {
            return false;
        }
    }

    function hasSellerApproved() public view returns (bool) {
        if (sellerApproval) {
            return true;
        } else {
            return false;
        }
    }
    
    function hasBuyerCancelled() public view returns (bool) {
        if(buyerCancel) {
            return true;
        }
        return false;
    }
    
    function hasSellerCancelled() public view returns (bool) {
        if(sellerCancel) {
            return true;
        }
        return false;
    }
    
    function getSellermount() public view returns (uint256) {
        return sellerAmount;
    }
    
    function totalEscrowBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function hasEscrowExpired() public view returns (bool) {
        if (blockNumber > block.number) {
            return false;
        } else {
            return true;
        }
    }
    
    function getBlockNumber() public view returns (uint256) {
        return block.number;
    }

    function withdraw() private {
        balances[user_B] = SafeMath.sub(balances[user_B], address(this).balance);
        balances[user_S] = SafeMath.add(balances[user_S], address(this).balance);
        eState = EscrowState.escrowComplete;
        sellerAmount = address(this).balance;
        user_S.transfer(address(this).balance);
    }

    function refund() private {
        user_B.transfer(address(this).balance);
    }
}