pragma solidity ^0.8.0;
import "./BalancerV2.sol";

contract Coin98BalancerV1 is BalancerV2 {
    using SafeMath for uint256;

    struct SwapParam {
        //uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        uint percent;
        bytes payload;
        //uint256 networkFee;
    }


    function swap(uint amount0Out, uint amount1Out, address payable to, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        //require(swapParam.index == 4, "Invalid Route");
        swapOnBalancer(
            swapParam.fromToken,
            swapParam.toToken,
            amount0Out,
            swapParam.targetExchange,
            swapParam.payload
        );
        uint256 balance = swapParam.toToken.balanceOf(address(this));
        Utils.transferTokens(address(swapParam.toToken), to, balance);
    }
}
