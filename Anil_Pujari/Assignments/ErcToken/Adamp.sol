// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Adamp is ERC20 {
    constructor(uint totalSupply) ERC20("Adamp", "ADP") {
        _mint(msg.sender, totalSupply * 10 ** decimals());
    }
}
