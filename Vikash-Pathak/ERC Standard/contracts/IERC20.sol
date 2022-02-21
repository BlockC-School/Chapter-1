// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface IERC20 {
//    mapping(address => uint256) private balances;
//    mapping(address => mapping(address => uint256)) private _allowances;

//    required function for ERC20 standard

   function totalSupply() external view returns (uint256);
   function balanceOf(address account) external view returns (uint256);
   function transfer(address recipient, uint amount) external returns (bool);
   function allowance(address owner, address spender) external view returns (uint);
   function approve(address spender, uint amount) external returns (bool);
   function transferFrom(address sender,address recipient,uint amount) external returns (bool);

//     important event for ERC20 standard
   event Transfer(address indexed _from, address indexed _to, uint256 _value);
   event approval(address indexed _owner, address indexed _spender, uint256 _value);
}