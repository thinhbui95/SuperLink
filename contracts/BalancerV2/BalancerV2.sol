pragma solidity ^0.8.0;
import "../interface/IBalancerV2.sol";
import "../library/Utils.sol";

abstract contract BalancerV2  {
    struct BalancerDataV2 {
        bytes32 poolId;
        IBalancerV2.SwapKind kind;
        bytes userData;
        bool fromInternalBalance;
        bool toInternalBalance;
        uint256 limit;
        uint256 deadline;
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
        Utils.approve(
                exchangeProxy,
                address(fromToken),
                fromAmount
        );
        BalancerDataV2 memory data = abi.decode(payload, (BalancerDataV2));
        IBalancerV2.SingleSwap memory singleSwap = IBalancerV2.SingleSwap(data.poolId,
                                                data.kind,
                                                IAsset(address(fromToken)),
                                                IAsset(address(toToken)),
                                                fromAmount,
                                                data.userData);
        
        IBalancerV2.FundManagement memory funds = IBalancerV2.FundManagement(address(this),
                                                data.fromInternalBalance,
                                                payable(address(this)),
                                                data.toInternalBalance);


        IBalancerV2(exchangeProxy).swap(singleSwap,funds,data.limit,data.deadline);






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