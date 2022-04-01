pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IComptroller.sol";
import "./ICToken.sol";
import "./IPriceOracle.sol";


contract BlockCDefi {
    ComptrollerInterface public comptroller;
    PriceOracleInterface public priceOracle;

    constructor(address _comptroller, address _priceOracle) {
        comptroller = ComptrollerInterface(_comptroller);
        priceOracle = PriceOracleInterface(_priceOracle);
    }



    function supply(address cTokenAddress, uint underlyingAmount)  public {
        CTokenInterface ctoken = CTokenInterface(cTokenAddress);
        address underlyingAddress = ctoken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint result = ctoken.mint(underlyingAmount);

        require(result == 0, "cToken.mint is not working");
    }

    function redeem(address cTokenAddress, uint cTokenAmount) external {
        CTokenInterface ctoken = CTokenInterface(cTokenAddress);
        uint result = ctoken.redeem(cTokenAmount);
        require(result == 0, "cToken.redeem is not working");
    }

    function enterMarket(address cTokenAddress) external {
        address[] memory markets = new address[](1);
        markets[0] = cTokenAddress;
        uint[] memory results = comptroller.enterMarkets(markets);

        require(
            results[0] == 0,
            "cToken.redeem is not working"
        );
    }

    function borrow(address cTokenAddress, uint borrowAmount) external {
        CTokenInterface ctoken = CTokenInterface(cTokenAddress);
        uint result = ctoken.borrow(borrowAmount);
        require(result == 0, "cToken.borrow is not working");
    }

    function repayBorrow(address cTokenAddress, uint underlyingAmount) external {
        CTokenInterface ctoken = CTokenInterface(cTokenAddress);
        address underlyingAddress = ctoken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint result = ctoken.repayBorrow(underlyingAmount);
        require(
            result == 0, "cToken.repayBorrow is not working"
        );
    }

    function getMaxBorrow(address cTokenAddress) external view returns(uint) {
       (uint result, uint liquidity, uint shortfall) = comptroller.getAccountLiquidity(address(this));

       require(
           result == 0, "comptroller.getAccountLiquidity is not working"
       );
       require(shortfall == 0, "account underwater");
       require(liquidity > 0, "account does not have collateral");
       uint underLyingPrice = priceOracle.getUnderlyingPrice(cTokenAddress);
       return liquidity / underLyingPrice;
    }
}