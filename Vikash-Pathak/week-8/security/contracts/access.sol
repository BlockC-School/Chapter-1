// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract AccessControl {
	uint256 public price;
	address private owner;
	// Deploye: Set the price
	constructor(uint256 _price) onlyOwner{
		price = _price;	
	}
	// Address: owner is Deployed address 
	modifier onlyOwner() {
		msg.sender == owner;
		_;
	}
    // Price: Owner can changes the price
	function updatePrice(uint256 _price) external {
		require(msg.sender == owner, 'Only owner should change the price');
		price = _price;
	}
	// OwnerPermission:
	
}

// it("Should set price at deployment", async function () {
			    
//     });

//     it("Should set the deployer account as the owner at deployment", async function () {
      
//     });

//     it("Should be possible for the owner to change price", async function () {
    
//     });

//     it("Should NOT be possible for other than the owner to change price", async function () {
      
//     });

//     it("Should be possible for the owner to transfer ownership", async function () {
     
//     });

//     it("Should be possible for a new owner to call updatePrice", async function () {
     
//     });

//     it("Should not be possible for other than the owner to transfer ownership", a