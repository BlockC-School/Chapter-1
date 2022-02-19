// SPDX-License-Identifier: Unlicensed
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
// import "./IRC20.sol";  // you can use which method is better suitable for you
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.11;
// I created safe math library but you can also import it from openzeppelin
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}


contract MyBerries is  ERC20 {
   address public admin;

   constructor() ERC20('MyBerries', 'MB') {
      _mint(msg.sender, 10000 * 10 ** 18);
      admin = msg.sender;
   }
   modifier onlyOwner() {
      require(msg.sender == admin);
      _;
   }
   function mint(address _to, uint256 _amount) public onlyOwner {
      require (msg.sender == admin, 'only for admin');
      mint(_to, _amount);
   }
   function burn(address account, uint amount) external onlyOwner {
   //    require (msg.sender == admin, 'only for admin');
   //   balanceOf[msg.sender] -= amount;
   //   totalSupply -= amount;
   //   emit Transfer(msg.sender, address(0), amount, data);
    require(amount != 0);
    require(amount <= _balances[account]);
    _totalSupply = _totalSupply.sub(amount);
    _balances[account] = _balances[account].sub(amount);
    emit Transfer(account, address(0), amount);
   }   
   function totalSupply() external view returns (uint) {
      return _totalSupply;
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
      allowance[msg.sender][spender] = amount;
      emit approval(msg.sender, spender, amount);
      return true;
   }
}