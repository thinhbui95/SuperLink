// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Maverick.sol";


contract Coin98Maverick is Maverick{
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



    function swap(uint amountIn, uint amountOut, bytes memory data) external  payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        swapOnMaverick(
            swapParam.fromToken,
            swapParam.toToken,
            amountIn,
            swapParam.targetExchange,
            swapParam.payload
        );

    }


}



