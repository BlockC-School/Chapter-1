//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

contract AgreedPrice {
    uint256 public price;
    address public owner;

    constructor(uint256 _price) {
        price = _price;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not an Owner");
        _;
    }

    function updatePrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}
