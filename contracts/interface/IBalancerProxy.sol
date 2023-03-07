pragma solidity ^0.8.0;


interface IBalancerProxy {

  struct Swap {
        address pool;
        uint tokenInParam; // tokenInAmount / maxAmountIn / limitAmountIn
        uint tokenOutParam; // minAmountOut / tokenAmountOut / limitAmountOut
        uint maxPrice;
    }

    function batchSwapExactIn(
        Swap[] memory swaps,
        address tokenIn,
        address tokenOut,
        uint totalAmountIn,
        uint minTotalAmountOut
    )
        external
        returns (uint totalAmountOut);

    function batchSwapExactOut(
        Swap[] memory swaps,
        address tokenIn,
        address tokenOut,
        uint maxTotalAmountIn
    )
        external
        returns (uint totalAmountIn);

    function batchEthInSwapExactIn(
        Swap[] memory swaps,
        address tokenOut,
        uint minTotalAmountOut
    )
        external
        payable
        returns (uint totalAmountOut);

    function batchEthOutSwapExactIn(
        Swap[] memory swaps,
        address tokenIn,
        uint totalAmountIn,
        uint minTotalAmountOut
    )
        external
        returns (uint totalAmountOut);

    function batchEthInSwapExactOut(
        Swap[] memory swaps,
        address tokenOut
    )
        external
        payable
        returns (uint totalAmountIn);

    function batchEthOutSwapExactOut(
        Swap[] memory swaps,
        address tokenIn,
        uint maxTotalAmountIn
    )
        external
        returns (uint totalAmountIn);
}
