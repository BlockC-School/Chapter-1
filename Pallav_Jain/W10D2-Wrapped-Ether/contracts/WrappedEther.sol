//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Weth is ERC20 {
    constructor() ERC20("Wrapped Ether", "WETH") {}

    function Deposit() external payable {
        _mint(msg.sender, msg.value);
    }

    function Withdrow(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficiant Fund");
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount;)
    } 
}


//Explanation Video
//https://drive.google.com/drive/folders/1dZj23WyFxdPeUHvBnF_DXPKb0A1Os8d_