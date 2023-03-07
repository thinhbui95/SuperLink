pragma solidity ^0.8.0;
import "../0xV2/LibOrderV2.sol";


interface IZeroxV2 {

    function marketSellOrdersNoThrow(
        LibOrderV2.Order[] memory orders,
        uint256 takerAssetFillAmount,
        bytes[] memory signatures
    )
        external
        returns(LibOrderV2.FillResults memory);
}


