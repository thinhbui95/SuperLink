pragma solidity ^0.8.0;

import "./KyberClassicStatic.sol";
import "../Helper.sol";

interface pairSwap{
    function token0() external returns(address);
}

contract Coin98KyberClassicStatic is KyberSwapClassicStatic {
    struct SwapParam {
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        bytes payload;
    }

    function swap(uint amountIn, uint amountOut, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));

        TransferHelper.transferERC20(address(swapParam.fromToken),amountIn,swapParam.targetExchange);
        
        if (pairSwap(swapParam.targetExchange).token0() == address(swapParam.fromToken)) {
            swapOnKyberSwapV1(
                0,
                amountOut,
                swapParam.targetExchange,
                swapParam.payload
            );
        } else {
            swapOnKyberSwapV1(
                amountOut,
                0,
                swapParam.targetExchange,
                swapParam.payload
            );
        }
    }
}