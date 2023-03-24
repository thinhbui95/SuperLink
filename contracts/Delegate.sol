// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./CurveV2/Coin98CurveV2.sol";
import "./Uniswap/Coin98Uniswap(V2).sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract Delegate  is Coin98UniswapV2,Coin98CurveV2 {
    mapping(uint256 => bytes4) Adapter;

    function addAdapter() external {
        Adapter[0] = Coin98CurveV2.swapCurveV2.selector;
        Adapter[1] = Coin98UniswapV2.swapUniV2.selector;
    }
}