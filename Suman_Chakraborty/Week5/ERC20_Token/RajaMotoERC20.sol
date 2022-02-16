// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RajaMotoERC20 is ERC20 {

    address public admin;

    constructor(uint _initialSupply) ERC20("RajaMotoERC20", "M20"){
        _mint(msg.sender, _initialSupply * 10 ** 18);
        admin=msg.sender;
    }

    modifier onlyAdmin{
        require(msg.sender == admin, "Only Admin Have the Access.");
        _;
    }

    function mint(address _to, uint _amount) external onlyAdmin{
        _mint(_to, _amount* 10 ** 18);
    }

    function burn(uint _amount) external{
        _burn(msg.sender, _amount);
    }

}