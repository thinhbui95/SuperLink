pragma solidity ^0.8.0;
import "./OneInchPool.sol";



contract Coin98ZeroxV2 is OneInchPool{
    using SafeMath for uint256;

    struct SwapParam {
        uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        uint percent;
        bytes payload;
        uint256 networkFee;
    }

    function swap(uint amountIn, uint amountOut, address to, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        require(swapParam.index == 7, "Invalid Route");
        swapOnOneInch(
            swapParam.fromToken,
            swapParam.toToken,
            amountIn,
            swapParam.targetExchange
        );
        uint256 balance = swapParam.toToken.balanceOf(address(this));
        swapParam.toToken.transfer(to, balance);
    }
}