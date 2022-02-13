// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20 {
// main state variables
    string public name;
    string private symbol;
    uint public decimals = 18;
    uint256 public totalSupply = 10000 * 10 ** 18;
// required function for ERC20 standard

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender,address recipient,uint amount) external returns (bool);

// important event for ERC20 standard
    event Transfer(address indexed _from, address indexed _to, uint256 _value , bytes _data);
    event approval(address indexed _owner, address indexed _spender, uint256 _value);    
}