pragma solidity ^0.8.0;
import "./ZeroxV2.sol";



contract Coin98ZeroxV2 is ZeroxV2{
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
    constructor(address _weth,address _erc20Proxy) 
    WethProvider(_weth)
    ZeroxV2(_erc20Proxy)  {}

    function swap(uint amount0Out, uint amount1Out,address payable to, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        require(swapParam.index == 2, "Invalid Route");
        swapOnZeroXv2(
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