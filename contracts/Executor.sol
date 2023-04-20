// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Helper.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";



interface SwapAdaptor {
    function swap(uint256 amountIn, uint256 amountOut, bytes memory data) external ;
}
contract Executor is Ownable, ReentrancyGuard{
    using EnumerableSet for EnumerableSet.AddressSet;

    struct ElementSwap {
        address[] adapters;
        uint256[] amountIns;
        uint256[] amountOuts;
        //address fromToken;
        bytes[] payloads;
    }
    EnumerableSet.AddressSet private whiteListAdapters;

    function getCall(uint256 amountIn, uint256 amountOut, bytes memory data) internal pure returns(bytes memory){
        return abi.encodeWithSelector(SwapAdaptor.swap.selector,amountIn,amountOut, data);
    }
    function addWhiteListAdapter(address[] memory _adapter) public onlyOwner {
        for (uint i = 0; i < _adapter.length; i++) {
            whiteListAdapters.add(_adapter[i]);
        }
    }


    function removeWhiteListAdapter(address[] memory _adapter) public onlyOwner {
        for (uint i = 0; i < _adapter.length; i++) {
            whiteListAdapters.remove(_adapter[i]);
        }
    }


    function chainRouter(bytes[] memory data) internal  {
        uint256 sizeChain = data.length;
        for (uint256 i; i<sizeChain; i++) {
            bytes[] memory elements = abi.decode(data[i],(bytes[]));
            uint256 sizeElements = elements.length;
            for (uint256 j; j<sizeElements; j++){
                ElementSwap memory element = abi.decode(elements[j], (ElementSwap));
                uint256[] memory amountIns = element.amountIns;
                uint256[] memory amountOuts = element.amountOuts;
                address[] memory adapters = element.adapters;
                bytes[] memory payloads = element.payloads;
                //address fromToken = element.fromToken;
                uint256 sizeElementSwap = amountIns.length;
                for (uint256 k ; k<sizeElementSwap; k++){
                    //TransferHelper.transferERC20(fromToken,amountIn[k],routers[k]);
                    bytes memory getcall = getCall(amountIns[k], amountOuts[k],payloads[k]);
                    require(whiteListAdapters.contains(adapters[k]),"Adapter in valid");
                    (bool success, ) = adapters[k].delegatecall(getcall);
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


















     
