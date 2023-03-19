pragma solidity ^0.8.0;
import "../utils/WethProvider.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../interface/IBalancerProxy.sol";
import "../interface/IBalancerPool.sol";
import "../library/Utils.sol";
import "../interface/IWETH.sol";

abstract contract BalancerV1 is WethProvider {
    using SafeMath for uint256;

    struct BalancerData {
        IBalancerProxy.Swap[] swaps;
    }

    function swapOnBalancer(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchangeProxy,
        bytes memory payload
    )
        internal
    {
        BalancerData memory data = abi.decode(payload, (BalancerData));

        address _fromToken = address(fromToken) == Utils.ethAddress()
            ? WETH : address(fromToken);
        address _toToken = address(toToken) == Utils.ethAddress()
            ? WETH : address(toToken);


        uint256 totalInParam;
        for (uint i = 0; i < data.swaps.length; ++i) {
            totalInParam = totalInParam.add(data.swaps[i].tokenInParam);
        }

        for (uint i = 0; i < data.swaps.length; ++i) {
            IBalancerProxy.Swap memory _swap = data.swaps[i];
            uint256 adjustedInParam =
                _swap.tokenInParam.mul(fromAmount).div(totalInParam);
            Utils.approve(
                _swap.pool,
                _fromToken,
                adjustedInParam
            );
            IBalancerPool(_swap.pool).swapExactAmountIn(
                _fromToken,
                adjustedInParam,
                _toToken,
                _swap.tokenOutParam,
                _swap.maxPrice
            );
        }

        // if (address(toToken) == Utils.ethAddress()) {
        //     IWETH(WETH).withdraw(
        //         IERC20(WETH).balanceOf(address(this))
        //     );
        // }
    }

    // function buyOnBalancer(
    //     IERC20 fromToken,
    //     IERC20 toToken,
    //     uint256 fromAmount,
    //     address exchangeProxy,
    //     bytes memory payload
    // )
    //     internal
    // {
    //     BalancerData memory data = abi.decode(payload, (BalancerData));

    //     address _fromToken = address(fromToken) == Utils.ethAddress()
    //         ? WETH : address(fromToken);
    //     address _toToken = address(toToken) == Utils.ethAddress()
    //         ? WETH : address(toToken);

    //     uint256 totalInParam;
    //     for (uint i = 0; i < data.swaps.length; ++i) {
    //         totalInParam = totalInParam.add(data.swaps[i].tokenInParam);
    //     }

    //     for (uint i = 0; i < data.swaps.length; ++i) {
    //         IBalancerProxy.Swap memory _swap = data.swaps[i];
    //         uint256 adjustedInParam =
    //             _swap.tokenInParam.mul(fromAmount).div(totalInParam);
    //         Utils.approve(
    //             _swap.pool,
    //             _fromToken,
    //             adjustedInParam
    //         );
    //         IBalancerPool(_swap.pool).swapExactAmountOut(
    //             _fromToken,
    //             adjustedInParam,
    //             _toToken,
    //             _swap.tokenOutParam,
    //             _swap.maxPrice
    //         );
    //     }

    //     if (
    //         address(fromToken) == Utils.ethAddress() ||
    //         address(toToken) == Utils.ethAddress()
    //     ) {
    //         IWETH(WETH).withdraw(
    //             IERC20(WETH).balanceOf(address(this))
    //         );
    //     }
    // }

}