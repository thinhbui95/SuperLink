pragma solidity ^0.8.0;
import "./curve.sol";
contract Coin98Adapter1 is Curve {
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

    function swap(uint amountIn, address to, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        require(swapParam.index == 3, "Invalid route");
        swapOnCurve(
            swapParam.fromToken,
            swapParam.toToken,
            amountIn,
            swapParam.targetExchange,
            swapParam.payload
        );
        uint256 balance = swapParam.toToken.balanceOf(address(this));
        swapParam.toToken.transfer(to, balance);
    }
}