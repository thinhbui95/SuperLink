pragma solidity ^0.8.0;
import "../utils/WethProvider.sol";
import "../library/Utils.sol";
import "../interface/ICurveV2Pool.sol";
import "../interface/IWETH.sol";


abstract contract CurveV2 is WethProvider {

    struct CurveV2Data {
        uint256 i;
        uint256 j;
        bool underlyingSwap;
    }

    constructor () {}

    function swapOnCurveV2(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    )
    internal

    {

        CurveV2Data memory curveV2Data = abi.decode(payload, (CurveV2Data));

        address _fromToken = address(fromToken);

        Utils.approve(address(exchange), address(_fromToken), fromAmount);
        if (curveV2Data.underlyingSwap) {
            ICurveV2Pool(exchange).exchange_underlying(curveV2Data.i, curveV2Data.j, fromAmount, 1);
        }
        else {
            ICurveV2Pool(exchange).exchange(curveV2Data.i, curveV2Data.j, fromAmount, 1);
        }

        // if (address(toToken) == Utils.ethAddress()) {
        //     uint256 receivedAmount = Utils.tokenBalance(WETH, address(this));
        //     IWETH(WETH).withdraw(receivedAmount);
        // }
    }
}