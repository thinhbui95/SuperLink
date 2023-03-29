// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./CurveV2.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/security/ReentrancyGuard.sol";



contract Coin98CurveV2 is CurveV2{
    using SafeMath for uint256;

    struct SwapParamCurveV2 {
        //uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        //uint percent;
        bytes payload;
        //uint256 networkFee;
    }


    function swap(uint amount0Out, uint amount1Out,  bytes memory data) external  {
        SwapParamCurveV2 memory swapParam = abi.decode(data, (SwapParamCurveV2));
        //require(swapParam.index == 9, "Invalid Route");
        //uint256 preBalance = swapParam.toToken.balanceOf(address(this));
        swapOnCurveV2(
                swapParam.fromToken,
                swapParam.toToken,
                amount0Out,
                swapParam.targetExchange,
                swapParam.payload
        );

        //uint256 balance = swapParam.toToken.balanceOf(address(this));
        //Utils.transferTokens(address(swapParam.toToken), to, balance - preBalance);

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




