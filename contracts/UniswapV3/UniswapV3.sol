// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../utils/WethProvider.sol";
import "../library/Utils.sol";
import "../interface/IWETH.sol";
import "../interface/ISwapRouterUniV3.sol";


abstract contract UniswapV3 is WethProvider{

  struct UniswapV3Data {
    uint24 fee;
    uint256 deadline;
    uint160 sqrtPriceLimitX96;
  }

  function swapOnUniswapV3(
    IERC20 fromToken,
    IERC20 toToken,
    uint256 fromAmount,
    address exchange,
    bytes memory payload
  )
    internal
  {

    UniswapV3Data memory data = abi.decode(payload, (UniswapV3Data));

    Utils.approve(address(exchange), address(fromToken), fromAmount);

    ISwapRouterUniV3(exchange).exactInputSingle(ISwapRouterUniV3.ExactInputSingleParams(
      {
      tokenIn : address(fromToken),
      tokenOut : address(toToken),
      fee : data.fee,
      recipient : address(this),
      deadline : data.deadline,
      amountIn : fromAmount,
      amountOutMinimum : 1,
      sqrtPriceLimitX96 : data.sqrtPriceLimitX96
      }
      )
    );

    // if (address(toToken) == Utils.ethAddress()) {
    //   IWETH(WETH).withdraw(
    //     IERC20(WETH).balanceOf(address(this))
    //   );
    // }

  }


  // function buyOnUniSwapV3(
  //   IERC20 fromToken,
  //   IERC20 toToken,
  //   uint256 fromAmount,
  //   uint256 toAmount,
  //   address exchange,
  //   bytes memory payload
  // )
  //   internal
  // {

  //   UniswapV3Data memory data = abi.decode(payload, (UniswapV3Data));

  //   address _fromToken = address(fromToken) == Utils.ethAddress()
  //   ? WETH : address(fromToken);
  //   address _toToken = address(toToken) == Utils.ethAddress()
  //   ? WETH : address(toToken);

  //   Utils.approve(address(exchange), _fromToken, fromAmount);

  //   ISwapRouterUniV3(exchange).exactOutputSingle(ISwapRouterUniV3.ExactOutputSingleParams(
  //     {
  //     tokenIn : _fromToken,
  //     tokenOut : _toToken,
  //     fee : data.fee,
  //     recipient : address(this),
  //     deadline : data.deadline,
  //     amountOut : toAmount,
  //     amountInMaximum : fromAmount,
  //     sqrtPriceLimitX96 : data.sqrtPriceLimitX96
  //     }
  //     )
  //   );

  //   if (
  //     address(fromToken) == Utils.ethAddress() ||
  //     address(toToken) == Utils.ethAddress()
  //   ) {
  //     IWETH(WETH).withdraw(
  //       IERC20(WETH).balanceOf(address(this))
  //     );
  //   }

  // }
}