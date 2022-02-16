// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


contract factory{

    event Deployed(address addr, uint salt);

    function getBytecode(address _user_A, uint _amount) public pure returns (bytes memory) {
        bytes memory bytecode = type(Escrow_contract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_user_A, _amount));
    }


    function getAddress(bytes memory bytecode, uint _salt) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );
        return address(uint160(uint(hash)));
    }

    function deploy(bytes memory bytecode, uint _salt) public payable {
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

        emit Deployed(addr, _salt);
    }
}

contract Escrow_contract {
    address public user_A;
    bool public work_done;
    uint amount;
    bool public is_paid;
    address payable user_B; 

    constructor(address _user_A, uint _amount) payable {
        user_A = _user_A;
        amount = _amount;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    modifier work() {
        require(work_done, "Work Not Done, Please done the work first");
        work_done = false;
        _;
    }

     modifier paid() {
        require(!is_paid, "User B is Already Paid");
        _;
        is_paid = true;
    }

    function payEther() public payable {}

    function getBalance() public view  returns (uint) {
        return address(this).balance;
    }

    function WorkDonebyUser_B() public returns (bool) {
       work_done = true;
       return work_done;
    }

    function sentEtherToUser_B(uint _amount, address payable _user_B) public payable validAddress(_user_B) paid work {
        address payable user = _user_B;
        user.transfer(_amount);
    }
}