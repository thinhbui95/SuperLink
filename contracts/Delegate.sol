// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;
// import "./CurveV2/Coin98CurveV2.sol";
// import "./Uniswap/Coin98Uniswap(V2).sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// contract Delegate  is Coin98UniswapV2,Coin98CurveV2,Ownable, ReentrancyGuard {
//     mapping(uint256 => bytes4) Adapter;

//     function addAdapter() external {
//         Adapter[0] = Coin98CurveV2.swapCurveV2.selector;
//         Adapter[1] = Coin98UniswapV2.swapUniV2.selector;
//     }

//     function withdrawStuckERC20(address _token) external payable onlyOwner{
//         uint256 balanceERC20 = IERC20(_token).balanceOf(address(this));
//         uint256 balanceNativeToken  = address(this).balance;
//         if (balanceERC20 > 0) {
//             IERC20(_token).transfer(owner(), balanceERC20);
//         }
//         if (balanceNativeToken > 0) {
//             payable(owner()).transfer(balanceERC20);
//         }
//     }
// }