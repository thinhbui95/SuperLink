pragma solidity ^0.8.0;



interface IAdapter {

  function swap(uint amount0Out, uint amount1Out, address to, bytes memory data) external payable;
}