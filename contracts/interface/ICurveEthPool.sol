pragma solidity ^0.8.0;
interface ICurveEthPool {

  function exchange(int128 i, int128 j, uint256 dx, uint256 minDy) external payable;
}