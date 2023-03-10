pragma solidity ^0.8.0;
import "../0xV4/LibOrderV4.sol";

interface IZeroxV4 {


    function fillRfqOrder(
        // The order
        LibOrderV4.Order memory order,
        // The signature
        LibOrderV4.Signature memory signature,
        // How much taker token to fill the order with
        uint128 takerTokenFillAmount
    )
        external
        payable
        // How much maker token from the order the taker received.
        returns (uint128, uint128);
}