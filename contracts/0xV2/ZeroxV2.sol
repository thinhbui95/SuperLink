//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "../utils/WethProvider.sol";
import "../library/LibBytes.sol";
import "../0xV2/LibOrderV2.sol";
import "../library/Utils.sol";
import "../interface/IZeroxV2.sol";

abstract contract ZeroxV2 is WethProvider {
    using LibBytes for bytes;

    struct ZeroxV2Data {
        LibOrderV2.Order[] orders;
        bytes[] signatures;
    }

    address public immutable erc20Proxy;

    constructor(address _erc20Proxy) {
        erc20Proxy = _erc20Proxy;
    }

    function swapOnZeroXv2(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    )
        internal

    {
        //address _fromToken = address(fromToken);

        _swapOn0xV2(
            fromToken,
            toToken,
            fromAmount,
            exchange,
            payload
        );

    }

    // function buyOnZeroXv2(
    //     IERC20 fromToken,
    //     IERC20 toToken,
    //     uint256 fromAmount,
    //     address exchange,
    //     bytes memory payload
    // )
    //     internal

    // {
    //     address _fromToken = address(fromToken);
    //     _swapOn0xV2(
    //         fromToken,
    //         toToken,
    //         fromAmount,
    //         exchange,
    //         payload
    //     );
    // }

    function _swapOn0xV2(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    )
        private
    {

        address _fromToken = address(fromToken);
        address _toToken = address(toToken);
        require(_fromToken != _toToken, "fromToken should be different from toToken");

        // if (_fromToken == Utils.ethAddress()) {
        //     _fromToken = WETH;
        // }

        // else if (_toToken == Utils.ethAddress()) {
        //     _toToken = WETH;
        // }

        ZeroxV2Data memory data = abi.decode(payload, (ZeroxV2Data));

        for (uint256 i = 0; i < data.orders.length; i++) {
            address srcToken = data.orders[i].takerAssetData.readAddress(16);
            require(srcToken == address(_fromToken), "Invalid from token!!");

            address destToken = data.orders[i].makerAssetData.readAddress(16);
            require(destToken == address(_toToken), "Invalid to token!!");
        }

        Utils.approve(erc20Proxy, address(_fromToken), fromAmount);

        IZeroxV2(exchange).marketSellOrdersNoThrow(
            data.orders,
            fromAmount,
            data.signatures
        );
    }
}