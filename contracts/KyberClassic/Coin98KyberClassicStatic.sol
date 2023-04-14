pragma solidity ^0.8.0;

import "./KyberClassicStatic.sol";
import "../Helper.sol";

interface pairSwap{
    function token0() external returns(address);
}

contract Coin98KyberClassicStatic is KyberSwapClassicStatic {

    uint256 private constant _KYBER_PAIR_SWAP_CALL_SELECTOR_32 =
        0x022c0d9f00000000000000000000000000000000000000000000000000000000;
    struct SwapParam {
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        bytes payload;
    }

    function poolSwap(
        uint256 _amount0,
        uint256 _amount1,
        address _pool,
        address _receiver
    ) internal {
        assembly {
            let emptyPtr := mload(0x40)
            mstore(0x40, add(emptyPtr, 0xc0))

            function reRevert() {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
            mstore(emptyPtr, _KYBER_PAIR_SWAP_CALL_SELECTOR_32)

            mstore(add(emptyPtr, 0x04), _amount0)
            mstore(add(emptyPtr, 0x24), _amount1)

            mstore(add(emptyPtr, 0x44), _receiver)
            mstore(add(emptyPtr, 0x64), 0x80)
            mstore(add(emptyPtr, 0x84), 0)
            if iszero(call(gas(), _pool, 0, emptyPtr, 0xa4, 0, 0)) {
                reRevert()
            }
        }
    }

    function swap(uint amountIn, uint amountOut, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));

        TransferHelper.transferERC20(address(swapParam.fromToken),amountIn,swapParam.targetExchange);

        // Call to swap function of Kyber swap pool

        // if (pairSwap(swapParam.targetExchange).token0() == address(swapParam.fromToken)) {
        //     swapOnKyberSwapV1(
        //         0,
        //         amountOut,
        //         swapParam.targetExchange,
        //         swapParam.payload
        //     );
        // } else {
        //     swapOnKyberSwapV1(
        //         amountOut,
        //         0,
        //         swapParam.targetExchange,
        //         swapParam.payload
        //     );
        // }

        // Call to pool using assembly
        if (pairSwap(swapParam.targetExchange).token0() == address(swapParam.fromToken)) {
            poolSwap(
                0,
                amountOut,
                swapParam.targetExchange,
                address(this)
            );
        } else {
            poolSwap(
                amountOut,
                0,
                swapParam.targetExchange,
                address(this)
            );
        }

    }
}