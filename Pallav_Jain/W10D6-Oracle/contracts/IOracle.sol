//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;


interface IOrecle {
    function UpdateReporter(address reporter, bool isReporter) external;

    function UpdateData(bytes32 key, uint256 payload) external;

    function getData(bytes32 key) external view returns(bool result, uint date, uint payload);
}