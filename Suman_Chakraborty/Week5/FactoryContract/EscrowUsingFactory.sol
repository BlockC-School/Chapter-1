//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./Escrow.sol";

contract EscrowUsingFactory{

    event DeployedSuccesfully(address addr, uint salt);

    Escrow[] public escrows;

    function create2Customized(bytes32 _salt) public{
        Escrow escrow = (new Escrow){salt: _salt}();
        escrows.push(escrow);
    }

    function create2CustomizedandSendEther(bytes32 _salt) public payable{
        Escrow escrow = (new Escrow){value: msg.value, salt: _salt}();
        escrows.push(escrow);
    }

    function getAll() external view returns (Escrow[] memory){
        return escrows;
    }

    function getSpecificInstance(uint _index) external view returns (Escrow ){
        Escrow escrow=escrows[_index];
        return escrow;
    }

    function getBytecode() public pure returns (bytes memory) {
        bytes memory bytecode = type(Escrow).creationCode;

        return abi.encodePacked(bytecode, abi.encode());
    }

    function getAddress(bytes memory bytecode, uint _salt) public view returns (address){
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

        emit DeployedSuccesfully(addr, _salt);
    }
}