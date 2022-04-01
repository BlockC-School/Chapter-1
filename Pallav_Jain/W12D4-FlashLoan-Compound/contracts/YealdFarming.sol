pragma solidity ^0.8.7;
pragma experimental ABIEncoderV2;

import "@studydefi/money-legos/dydx/contracts/DydxFlashloanBase.sol";
import "@studydefi/money-legos/dydx/contracts/ICallee.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract YieldFarmer is ICallee, DydxFlashloanBase {
    enum Direction { Deposit, Withdraw }

    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    struct Operation {
        address token;
        address cToken;
        Direction direction;
        uint amountProvided;
        uint amountBorrowed;
    }

    function callFunction(address sender, Account.Info memory account, bytes memory data) public {
        
    }

    function _initateFlashloan(
        address _solo,
        address _token,
        address _cToken,
        Direction _direction,
        uint _amountProvided,
        uint _amountBorrowed
    ) internal {
        ISoloMargin solo = ISoloMargin(_solo);

        uint256 marketId = _getMarketIdFromTokenAddress(_solo, _token);

        // get the repayement amoount (_amount + 2 wei)
        uint256 repayAmount = _getRepaymentAmountInternal(_amountBorrowed);
        IERC20(_token).approve(_solo, repayAmount);

        // Withdraw the funds dydx - get the flash loan
        // Call the callback
        // Rembuirse the loan 

        Actions.ActionArgs[] memory operations = new Actions.ActionArgs[](3);

        operations[0] = _getWithdrawAction(marketId, _amountBorrowed);
        operations[1] = _getCallAction(abi.encode(Operation({
            token: _token,
            cToken: _cToken,
            direction: _direction,
            amountProvided : _amountProvided,
            amountBorrowed: _amountBorrowed
        })));

        operations[2] = _getDepositAction(marketId, repayAmount);
        Account.Info[] memory accountInfos = new Account.Info[](1);
        solo.operate(accountInfos, operations);
    }
}