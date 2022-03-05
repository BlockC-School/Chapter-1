//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

import "./CrowdFund.sol";

contract CrowdFundFactory{
    address[] public crowdFundList;

    function getByteCode(uint256 _minimumDonation, uint256 _deadline, uint256 _targetFund, string memory _description, string memory _image) private pure returns (bytes memory) {
        bytes memory bytecode = type(CrowdFund).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_minimumDonation, _deadline, _targetFund, _description, _image));
    }

    function getAddress(bytes memory bytecode, uint _salt) private view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        // NOTE: cast last 20 bytes of hash to address
        return address(uint160(uint(hash)));
    }

    function deploy(bytes memory bytecode, uint _salt) public payable {
        address addr;

        /*
        NOTE: How to call create2

        create2(v, p, n, s)
        create new contract with code at memory p to p + n
        and send v wei
        and return the new address
        where new address = first 20 bytes of keccak256(0xff + address(this) + s + keccak256(mem[p…(p+n)))
              s = big-endian 256-bit value
        */

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

      crowdFundList.push(addr);
        
    }


    function createNewFund (uint256 _minimumDonation, uint256 _deadline, uint256 _targetFund, string memory _description, string memory _image) public payable{
      // CrowdFund crowdFund = new CrowdFund(_minimumDonation,  _deadline, _targetFund,  _description);
      // crowdFundList.push(crowdFund);

      bytes memory byteCode = getByteCode(_minimumDonation, _deadline, _targetFund, _description, _image);
      address fundContractAddress = getAddress(byteCode, 123);
    //   deploy(byteCode, 123);

      crowdFundList.push(fundContractAddress);

    }
}