//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestNetToken is ERC20 {
   address public admin;

   constructor () ERC20("TestNet Token", "TNT"){
       _mint(msg.sender, 1000 * 10 ** 5);
       admin = msg.sender;
   }

   function mint(address _to, uint _amount) public checkIfAdmin {
       _mint(_to, _amount);
   }

   function burn(uint _amount) public {
       _burn(msg.sender, _amount);
   }

    modifier checkIfAdmin(){
        require(msg.sender != admin, "Not an Authorized Person !!");
        _;
    }
}