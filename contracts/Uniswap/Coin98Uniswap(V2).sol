// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
//import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
import "../Helper.sol";
interface pairSwap{
    function token0() external returns(address);
}


abstract contract Coin98UniswapV2 {
    uint256 private constant _UNISWAP_PAIR_SWAP_CALL_SELECTOR_32 =
        0x022c0d9f00000000000000000000000000000000000000000000000000000000;

    struct SwapParamUniV2 {
        //uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        //uint percent;
        bytes payload;
        //uint256 networkFee;
    }

    address public token0;
    address public token1;

    function poolSwap(
        uint256 _amount,
        address _pool,
        bool _tokenInOut,
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

            switch iszero(_tokenInOut)
            case 0 {
                mstore(add(emptyPtr, 0x04), 0)
                mstore(add(emptyPtr, 0x24), _amount) //B>A
            }
            default {
                mstore(add(emptyPtr, 0x04), _amount) //A>B
                mstore(add(emptyPtr, 0x24), 0)
            }
            mstore(add(emptyPtr, 0x44), _receiver)
            mstore(add(emptyPtr, 0x64), 0x80)
            mstore(add(emptyPtr, 0x84), 0)
            if iszero(call(gas(), _pool, 0, emptyPtr, 0xa4, 0, 0)) {
                reRevert()
            }
        }
    }


    function swapUniV2(uint256 amount0Out, uint256 amount1Out, bytes memory data) external{

        SwapParamUniV2 memory swapParam = abi.decode(data, (SwapParamUniV2));
        //require(swapParam.index == 10, "Invalid Route");
        TransferHelper.transferERC20(address(swapParam.fromToken),amount0Out,swapParam.targetExchange);
        // TransferHelper.transferERC20(address(swapParam.fromToken), IERC20(swapParam.fromToken).balanceOf(address(this)),swapParam.targetExchange);
        if (pairSwap(swapParam.targetExchange).token0() != address(swapParam.fromToken)) {
            poolSwap(amount1Out, swapParam.targetExchange,false, address(this));
        } else {
            poolSwap(amount1Out, swapParam.targetExchange,true, address(this));
        }
    }

    // function withdrawStuckERC20(address _token) external payable onlyOwner{
    //     uint256 balanceERC20 = IERC20(_token).balanceOf(address(this));
    //     uint256 balanceNativeToken  = address(this).balance;
    //     if (balanceERC20 > 0) {
    //         IERC20(_token).transfer(owner(), balanceERC20);
    //     }
    //     if (balanceNativeToken > 0) {
    //         payable(owner()).transfer(balanceERC20);
    //     }
    // }
}