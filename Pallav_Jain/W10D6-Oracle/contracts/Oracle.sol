//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

contract Oracle {
    struct Data {
        uint256 date;
        uint256 payload;
    }

    address public admin;
    mapping(address => bool) public reporters;
    mapping(bytes32 => Data) public data;

    constructor(address _admin) {
        admin = _admin;
    }

    function UpdateReporter(address reporter, bool isReporter) external {
        require(msg.sender == admin, "Only Admin Allowed");
        reporters[reporter] = isReporter;
    }

    function UpdateData(bytes32 key, uint256 payload) external {
        require(reporters[msg.sender] == true, "Only Reporters Can Send");
        data[key] = Data(block.timestamp, payload);
    }

    function getData(bytes32 key) external view returns(bool result, uint date, uint payload) {
        if(data[key].date == 0 ){
            return(false, 0, 0);
        }

        return(true, data[key].date, data[key].payload);
    }
}
