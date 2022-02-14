// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */

 contract EscrowFactory{

    event Deployed(address addr, uint salt);


  
    function getBytecode(address _ownerA, address payable _ownerB, uint _price) public pure returns (bytes memory) {
        bytes memory bytecode = type(Escorw).creationCode;

        // if constructor accepting some value we have to pass here only

        return abi.encodePacked(bytecode, abi.encode(_ownerA, _ownerB, _price));
    }

   
    function getAddress(bytes memory bytecode, uint _salt)
        public
        view
        returns (address)
    {
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

        emit Deployed(addr, _salt);
    }
 }

 contract Escorw {
    enum Status {
        NOT_INITIATED,
        AWATING_PAYMENT,
        AWATING_DELIVERY,
        PROCESS_COMPLETED
    }

    bool public isUserA;
    bool public isUserB;

    Status public currentStatus;

    uint public price;

    address public userB;
    address payable public userA;

    modifier onlyForUserB(){
        require(msg.sender == userB, "Only UserB can call this function !");
        _;
    }

    modifier notStarted(){
        require(currentStatus == Status.NOT_INITIATED, "Not started yet !");
        _;
    }

    constructor(address _userB, address payable _userA, uint _price) payable {
        userB = _userB;
        userA = _userA;
        price = _price * (1 ether);
    }

    function initiateContract() notStarted public {
        if(msg.sender == userB){
            isUserB = true;
        }

        if(msg.sender == userA){
            isUserA = true;
        }

        if(isUserB && isUserA){
            currentStatus = Status.AWATING_PAYMENT;
        }
    }

    function coniformPayment() onlyForUserB payable public {
        require(currentStatus == Status.AWATING_DELIVERY, "Cannot coniform payment !");
        userA.transfer(price);
        currentStatus = Status.PROCESS_COMPLETED;
    }

    function deposit() onlyForUserB payable public {
        require(currentStatus == Status.AWATING_PAYMENT, "Already paid !");
        require(msg.value == price, "Wrong amount");
        currentStatus = Status.AWATING_DELIVERY;
    }
}
