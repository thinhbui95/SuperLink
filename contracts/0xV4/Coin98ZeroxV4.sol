pragma solidity ^0.8.0;
import "./ZeroxV4.sol";



contract Coin98ZeroxV4 is ZeroxV4{
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
    // constructor(address _weth) WethProvider(_weth)  {
    // }
    function swap(uint amount0Out, uint amount1Out, address to, bytes memory data) external  payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        require(swapParam.index == 1, "Invalid Route");
        swapOnZeroXv4(
                swapParam.fromToken,
                swapParam.toToken,
                amount0Out,
                swapParam.targetExchange,
                swapParam.payload
        );

        uint256 balance = swapParam.toToken.balanceOf(address(this));
        swapParam.toToken.transfer(to, balance);
    }

}


