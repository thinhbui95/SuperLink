// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../interface/IDODOV2Proxy.sol";
import "../library/Utils.sol";



abstract contract DoDoV2  {



    struct SwapDoDoV2 {
        address[] dodoPairs;
        uint256 directions;
        address  dodoErc20Approve;
        uint256  dodoV2SwapLimitOverhead;

    }

    // constructor (address _dodoErc20ApproveProxy,uint256 _dodoV2SwapLimitOverhead) {
    //     dodoErc20ApproveProxy = _dodoErc20ApproveProxy;
    //     dodoV2SwapLimitOverhead = _dodoV2SwapLimitOverhead;
    // }

    function swapOnDodoV2(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange, 
        bytes memory payload
    )
    internal

    {
        SwapDoDoV2 memory dodoV2 = abi.decode(payload, (SwapDoDoV2));
        Utils.approve(dodoV2.dodoErc20Approve, address(fromToken), fromAmount);
        IDODOV2Proxy(exchange).dodoSwapV2TokenToToken(
                address(fromToken),
                address(toToken),
                fromAmount,
                1,
                dodoV2.dodoPairs,
                dodoV2.directions,
                false,
                block.timestamp + dodoV2.dodoV2SwapLimitOverhead
            );
    }



}