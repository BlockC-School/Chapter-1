// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Price {
	uint256 public price;
  address public owner;
	
	constructor(uint256 _price) {
		price = _price;
    owner = msg.sender;
	}

  function transferOwnerShip(address _newOwner) public {
    require(msg.sender == owner, "Only owner can transfer the ownership");
    owner = _newOwner;
  }

	function updatePrice(uint256 _price) external {
    require(msg.sender == owner, "Only owner can update price");
		price = _price;
	}
  
}