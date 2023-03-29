pragma solidity ^0.8.0;
import "../interface/IZeroxV4.sol";
import "../utils/WethProvider.sol";
import "../library/Utils.sol";
// import "../interface/IWETH.sol";



abstract contract ZeroxV4  {

    struct ZeroxV4Data {
        LibOrderV4.Order order;
        LibOrderV4.Signature signature;
    }

    function swapOnZeroXv4(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    )
        internal
    {
        _swapOn0xV4(
            fromToken,
            toToken,
            fromAmount,
            exchange,
            payload
        );
    }

    function buyOnZeroXv4(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    )
        internal
    {
        _swapOn0xV4(
            fromToken,
            toToken,
            fromAmount,
            exchange,
            payload
        );

        // if (address(fromToken) == Utils.ethAddress()) {
        //     uint256 remainingAmount = Utils.tokenBalance(WETH, address(this));
        //     if (remainingAmount > 0) {
        //       IWETH(WETH).withdraw(remainingAmount);
        //     }
        // }
    }

    function _swapOn0xV4(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload) private {

        ZeroxV4Data memory data = abi.decode(payload, (ZeroxV4Data));

        address _fromToken = address(fromToken);
        address _toToken = address(toToken);
        require(_fromToken != _toToken, "fromToken should be different from toToken");

        // if (address(fromToken) == Utils.ethAddress()) {
        //     _fromToken = WETH;
        // }
        // else if (address(toToken) == Utils.ethAddress()) {
        //     _toToken = WETH;
        // }

        require(address(data.order.takerToken) == address(_fromToken), "Invalid from token!!");
        require(address(data.order.makerToken) == address(_toToken), "Invalid to token!!");

        Utils.approve(exchange, address(_fromToken), fromAmount);

        IZeroxV4(exchange).fillRfqOrder(
            data.order,
            data.signature,
            uint128(fromAmount)
        );

        // if (address(toToken) == Utils.ethAddress()) {
        //     uint256 receivedAmount = Utils.tokenBalance(WETH, address(this));
        //     IWETH(WETH).withdraw(receivedAmount);
        // }
    }
}