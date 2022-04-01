//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

import "./IOracle.sol";

//DEX=Decentrilize Exchange

contract DEXConsumer {
    IOrecle public oracle;

    constructor(address _oracle) {
        oracle = IOrecle(_oracle);
    }

    function trade() external {
        bytes32 key = keccak256(abi.encodePacked("BTC/USD"));

        (bool result, uint timestamp, uint data) = oracle.getData(key);

        //do something with data
    }
}
