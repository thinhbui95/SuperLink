// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./DoDoV2.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";


abstract contract Coin98DoDoV2 is DoDoV2{
    using SafeMath for uint256;

    struct SwapParam {
        //uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        //uint percent;
        bytes payload;
        //uint256 networkFee;
    }

    // constructor(address _dodoErc20ApproveProxy,uint256 _dodoV2SwapLimitOverhead) DoDoV2(_dodoErc20ApproveProxy,_dodoV2SwapLimitOverhead) {}

    function swap(uint amount0Out, uint amount1Out, bytes memory data) external  payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        //require(swapParam.index == 9, "Invalid Route");
        // uint256 preBalance = swapParam.toToken.balanceOf(address(this));
        swapOnDodoV2(
                swapParam.fromToken,
                swapParam.toToken,
                amount0Out,
                swapParam.targetExchange,
                swapParam.payload
        );

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



