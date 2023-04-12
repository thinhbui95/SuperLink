// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../library/Utils.sol";
import "../interface/IKyberSwapV1Static.sol";

contract KyberSwapClassicStatic {

    // struct KyberSwapClassicStaticData {
    //     uint256 amountOutMin;
    //     address[] poolsPath;
    //     IERC20[] path;
    //     address to;
    //     uint256 deadline;
    // }

    // function swapExactTokensForTokens(
    //     IERC20 fromToken,
    //     uint256 fromAmount,
    //     bytes memory payload
    // ) internal {
    //     KyberSwapClassicStaticData memory data = abi.decode(payload, (KyberSwapClassicStaticData));
    //     Utils.approve(address(fromToken), address(this), fromAmount);
    //     IKyberSwapV1Static(address(this)).swapExactTokensForTokens(
    //         fromAmount,
    //         data.amountOutMin,
    //         data.poolsPath,
    //         data.path,
    //         data.to,
    //         data.deadline
    //     );
    // }

    struct KyberSwapClassicStaticData {
        address to;
        bytes data;
    }
        
    function swapOnKyberSwapV1(
        uint256 amount0Out,
        uint256 amount1Out,
        address targetExchange,
        bytes memory payload
    ) internal {
        KyberSwapClassicStaticData memory kyberSwapClassicStaticData = abi.decode(payload, (KyberSwapClassicStaticData));

        IKyberSwapV1Static(targetExchange).swap(
            amount0Out,
            amount1Out,
            kyberSwapClassicStaticData.to,
            kyberSwapClassicStaticData.data
        );
    }


}