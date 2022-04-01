//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CollateralBackedToken is ERC20 {
    IERC20 public collatral;
    uint256 public price = 1;

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collatral = IERC(_collateral);
    }

    function Depost(uint256 collatralAmount) external {
        collatral.transferFrom(msg.sender, address(this), collatralAmount);

        _mint(msg.sender, collatralAmount * price);
    }

    function Withdrow(uint256 tokenAmount) external {
        require(balanceOf(msg.sender) >= tokenAmount, "Insufficiant Balance");
        _burn(msg.sender, tokenAmount);
        collatral.transfer(msg.sender, tokenAmount / price);
    }
}

//Explaination Video
//https://drive.google.com/drive/folders/1dZj23WyFxdPeUHvBnF_DXPKb0A1Os8d_