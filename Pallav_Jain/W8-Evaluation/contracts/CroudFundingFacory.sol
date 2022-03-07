// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./CroudFunding.sol";

contract CroudFundFactory {
    address[] public addressList;

    event Deployed(address addr, uint256 salt);

    function getBytecode(
        uint256 _target,
        uint256 _deadline,
        string memory _description
    ) public pure returns (bytes memory) {
        bytes memory bytecode = type(CroudFunding).creationCode;

        return
            abi.encodePacked(
                bytecode,
                abi.encode(_target, _deadline, _description)
            );
    }

    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(bytecode)
            )
        );
        return address(uint160(uint256(hash)));
    }

    function deploy(bytes memory bytecode, uint256 _salt)
        public
        payable
        returns (address)
    {
        address addr;

        assembly {
            addr := create2(
                callvalue(), // wei sent with current call
                // Actual code starts after skipping the first 32 bytes
                add(bytecode, 0x20),
                mload(bytecode), // Load the size of code contained in the first 32 bytes
                _salt // Salt from function arguments
            )

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        addressList.push(addr);
        emit Deployed(addr, _salt);
        return addr;
    }

    function getPerticularFund(uint256 _index) public view returns (address) {
        return addressList[_index];
    }
}
