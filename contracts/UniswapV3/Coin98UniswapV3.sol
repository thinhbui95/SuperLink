pragma solidity ^0.8.0;
import "./UniswapV3.sol";



contract Coin98UniswapV3 is UniswapV3{
    using SafeMath for uint256;

    struct SwapParam {
        //uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        //uint percent;
        bytes payload;
        //uint256 networkFee;
    }
    // constructor(address _weth) WethProvider(_weth) {}

    function swap(uint amountIn, uint amountOut, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        //require(swapParam.index == 5, "Invalid Route");
        swapOnUniswapV3(
            swapParam.fromToken,
            swapParam.toToken,
            amountIn,
            swapParam.targetExchange,
            swapParam.payload
        );
        // uint256 balance = swapParam.toToken.balanceOf(address(this));
        // Utils.transferTokens(address(swapParam.toToken), to, balance);
    }
}