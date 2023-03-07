pragma solidity ^0.8.0;
import "../library/Utils.sol";
import "../interface/IMStable.sol";

contract MStable {
    enum OpType {
        swap,
        mint,
        redeem
    }

    struct MStableData {
        uint opType;
    }

    function swapOnMStable(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 fromAmount,
        address exchange,
        bytes memory payload
    )
    internal

    {

        MStableData memory data = abi.decode(payload, (MStableData));
        Utils.approve(exchange, address(fromToken), fromAmount);

        if (data.opType == uint(OpType.mint)) {
            IMStable(exchange).mint(address(fromToken), fromAmount, 1, address(this));
        } else if (data.opType == uint(OpType.redeem)) {
            IMStable(exchange).redeem(address(toToken), fromAmount, 1, address(this));
        } else if (data.opType == uint(OpType.swap)) {
            IMStable(exchange).swap(address(fromToken), address(toToken), fromAmount, 1, address(this));
        } else {
            revert("Invalid opType");
        }
    }
}
