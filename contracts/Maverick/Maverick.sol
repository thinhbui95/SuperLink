// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interface/ISwapRouterMaverick.sol";

abstract contract Maverick  {
    struct MaverickData {
        address pool;
        uint256 deadline;
    }

    function swapOnMaverick(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    ) internal {
        MaverickData memory data = abi.decode(payload, (MaverickData));


        Utils.approve(address(exchange), address(fromToken), fromAmount);

        ISwapRouterMaverick(exchange).exactInputSingle(
            ISwapRouterMaverick.ExactInputSingleParams({
                tokenIn: address(fromToken),
                tokenOut: address(toToken),
                pool: data.pool,
                recipient: address(this),
                deadline: data.deadline,
                amountIn: fromAmount,
                amountOutMinimum: 1,
                sqrtPriceLimitD18: 0
            })
        );

    }

   
}