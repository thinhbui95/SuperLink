// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;
// import "./Helper.sol";
// import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
// import './Uniswap/Coin98Uniswap(V2).sol';
    


// interface SwapAdaptor {
//     function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes memory data) external ;
// }
// contract Executor {
//     function getCall(uint256 amount0Out, uint256 amount1Out, address to, bytes memory data) internal pure returns(bytes memory){
//         return abi.encodeWithSelector(SwapAdaptor.swap.selector,amount0Out,amount1Out, to, data);
//     }
//     struct ElementSwap {
//         bytes encodeRouters;
//         bytes encodeAmountIn;
//         bytes encodeAmountOut;
//         address fromToken;
//         bytes encodePayload;

//     }

//     mapping(uint256 => SwapAdaptor) adaptor;
//     adaptor[0] = 


//     function chainRouter(bytes[] memory data) public  {
//         uint256 sizeChain = data.length;
//         for (uint256 i; i<sizeChain; i++) {
//             bytes[] memory elements = abi.decode(data[i],(bytes[]));
//             uint256 sizeElements = elements.length;
//             for (uint256 j; j<sizeElements; j++){
//                 ElementSwap memory element = abi.decode(elements[j], (ElementSwap));
//                 uint256[] memory amountIn = abi.decode(element.encodeAmountIn, (uint256[]));
//                 uint256[] memory amountOut = abi.decode(element.encodeAmountOut, (uint256[]));
//                 address[] memory routers = abi.decode(element.encodeRouters, (address[]));
//                 bytes[] memory payloads = abi.decode(element.encodePayload, (bytes[]));
//                 address fromToken = element.fromToken;
//                 uint256 sizeElementSwap = amountIn.length;
//                 for (uint256 k ; k<sizeElementSwap; k++){
//                     TransferHelper.transferERC20(fromToken,amountOut[k],routers[k]);
//                     bytes memory getcall = getCall(amountIn[k], amountOut[k],address(this),payloads[k]);
//                     (bool success, ) = routers[k].call(getcall);
//                     require(success,"Failed Call");
//                 }
//             }
//         }
//     }
//     function execution(bytes memory data, address from, address toToken) external {
//         bytes[] memory dataChain = abi.decode(data, (bytes[]));
//         chainRouter(dataChain);
//         TransferHelper.transferERC20(toToken, IERC20(toToken).balanceOf(address(this)), from);
//     }
// }


















     
