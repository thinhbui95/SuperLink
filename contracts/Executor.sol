// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Helper.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./CurveV2/Coin98CurveV2.sol";
import "./Uniswap/Coin98Uniswap(V2).sol";


// interface SwapAdaptor {
//     function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes memory data) external ;
// }
contract Executor is Ownable, ReentrancyGuard, Coin98UniswapV2,Coin98CurveV2{
    function getCall(bytes4 adapter,uint256 amount0Out, uint256 amount1Out, bytes memory data) internal pure returns(bytes memory){
        return abi.encodeWithSelector(adapter,amount0Out,amount1Out, data);
    }
    struct ElementSwap {
        bytes encodeAdapter;
        bytes encodeAmountIn;
        bytes encodeAmountOut;
        //address fromToken;
        bytes encodePayload;

    }
    mapping(uint256 => bytes4) Adapter;
    constructor() 
    {
        Adapter[0] = Coin98CurveV2.swapCurveV2.selector;
        Adapter[1] = Coin98UniswapV2.swapUniV2.selector;

    }

    
    //Adapter[0] = Coin98CurveV2.swap.selector;



    function chainRouter(bytes[] memory data) internal  {
        uint256 sizeChain = data.length;
        for (uint256 i; i<sizeChain; i++) {
            bytes[] memory elements = abi.decode(data[i],(bytes[]));
            uint256 sizeElements = elements.length;
            for (uint256 j; j<sizeElements; j++){
                ElementSwap memory element = abi.decode(elements[j], (ElementSwap));
                uint256[] memory amountIn = abi.decode(element.encodeAmountIn, (uint256[]));
                uint256[] memory amountOut = abi.decode(element.encodeAmountOut, (uint256[]));
                uint256[] memory indexs = abi.decode(element.encodeAdapter, (uint256[]));
                bytes[] memory payloads = abi.decode(element.encodePayload, (bytes[]));
                //address fromToken = element.fromToken;
                uint256 sizeElementSwap = amountIn.length;
                for (uint256 k ; k<sizeElementSwap; k++){
                    //TransferHelper.transferERC20(fromToken,amountIn[k],routers[k]);
                    bytes memory getcall = getCall(Adapter[indexs[k]],amountIn[k], amountOut[k],payloads[k]);
                    (bool success, ) = address(this).call(getcall);
                    require(success,"Failed Call");
                }
            }
        }
    }
    function execution(bytes memory data, address from, address toToken) external nonReentrant{
        bytes[] memory dataChain = abi.decode(data, (bytes[]));
        uint256 balanceInNextTo = IERC20(toToken).balanceOf(address(this));
        chainRouter(dataChain);
        TransferHelper.transferERC20(toToken, IERC20(toToken).balanceOf(address(this)) - balanceInNextTo, from);
    }

    function withdrawStuckERC20(address _token) external payable onlyOwner{
        uint256 balanceERC20 = IERC20(_token).balanceOf(address(this));
        uint256 balanceNativeToken  = address(this).balance;
        if (balanceERC20 > 0) {
            IERC20(_token).transfer(owner(), balanceERC20);
        }
        if (balanceNativeToken > 0) {
            payable(owner()).transfer(balanceERC20);
        }
    }
}


















     
