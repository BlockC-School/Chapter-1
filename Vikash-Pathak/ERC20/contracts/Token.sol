// SPDX-License-Identifier: Unlicense
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
import "./IERC20.sol";
import "./ERC20.sol";
pragma solidity ^0.8.11;

contract MyBerries is IERC20, ERC20 {
   address public admin;

   constructor() ERC20('MyBerries', 'MB') {
      _mint(msg.sender, 10000 * 10 ** 18);
      admin = msg.sender;
   }
   function mint(address _to, uint256 _amount) public externel {
      require (msg.sender == admin, 'only for admin');
      _mint(_to, _amount);
   }
   function burn(uint amount) external {
      require (msg.sender == admin, 'only for admin');
     _balanceOf[msg.sender] -= amount;
     _totalSupply -= amount;
     _burn(msg.sender, amount);
     emit Transfer(msg.sender, address(0), amount, data);
   }   
   function totalSupply() external view returns (uint) {
      return totalSupply;
   }
   function balanceOf(address _owner) external view returns (uint) {
      return balances[_owner];
   }
   function transfer(address _to, uint _value) external returns (bool) {
      require (balances[msg.sender] >= _value, 'insufficient balance');
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      Transfer(msg.sender, _to, _value);
      return true;
   }
   function approve(address owner, address spender, uint256 amount) public returns (bool) {
      require (balances[msg.sender] >= amount, 'insufficient balance');
      allowed[msg.sender][spender] = amount;
      Approval(msg.sender, spender, amount);
      return true;
   }
}