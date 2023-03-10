// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import "../Helper.sol";

contract Coin98Uniswap {
    uint256 private constant _UNISWAP_PAIR_SWAP_CALL_SELECTOR_32 =
        0x022c0d9f00000000000000000000000000000000000000000000000000000000;

    struct SwapParam {
        uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        uint percent;
        bytes payload;
        uint256 networkFee;
    }

    function poolSwap(
        uint256 _amount0Out,
        uint256 _amount1Out,
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
            mstore(emptyPtr, _UNISWAP_PAIR_SWAP_CALL_SELECTOR_32)
            mstore(add(emptyPtr, 0x04), _amount0Out)
            mstore(add(emptyPtr, 0x24), _amount1Out)

            mstore(add(emptyPtr, 0x44), _receiver)
            mstore(add(emptyPtr, 0x64), 0x80)
            mstore(add(emptyPtr, 0x84), 0)
            if iszero(call(gas(), _pool, 0, emptyPtr, 0xa4, 0, 0)) {
                reRevert()
            }
        }
    }


    function swapUniV2(uint256 amount0Out, uint256 amount1Out, address to, bytes memory data) external payable{

        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        require(swapParam.index == 10, "Invalid Route");
        TransferHelper.transferERC20(address(swapParam.fromToken), IERC20(swapParam.fromToken).balanceOf(address(this)),swapParam.targetExchange);
        poolSwap(amount0Out, amount1Out, swapParam.targetExchange, to);


    }
}