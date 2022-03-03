// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract AccessControl {

	event approval(uint256 amount,bool agree);

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
	mapping(address => bool) public agreed;
	// OwnerPermission: Permission to change price
	function restrictedPrice(uint256 _price, bool agree) public onlyOwner{
		msg.sender == owner;
		require(agree == false, "already approved");
		agreed[owner];
		price = _price;
		emit approval(price, agree);		
	}
	// TransferOwnership: To New Address
	function transferOwnership(address _newOwner) external view onlyOwner{
		require(_newOwner != address(0), "Don't set it to address 0 ");
		owner == _newOwner;
	}
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