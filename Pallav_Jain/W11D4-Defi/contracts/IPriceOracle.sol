pragma solidity ^0.8.6;

interface PriceOracleInterface {
  function getUnderlyingPrice(address asset) external view returns(uint);
}