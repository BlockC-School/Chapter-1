//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract MyToken is ERC20 {
    address public admin;

    constructor(uint amount) ERC20('My Token', 'MTN') {
        _mint(msg.sender, amount);
        admin = msg.sender;
    }

    function mint(address to, uint amount) external {
        require(admin == msg.sender, 'Only Admin Allowed');
        _mint(to, amount);
    }
}