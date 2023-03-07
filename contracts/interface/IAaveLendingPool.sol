pragma solidity ^0.8.0;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface IAaveLendingPool {
  function deposit(
    IERC20 asset,
    uint256 amount,
    address onBehalfOf,
    uint16 referralCode
  ) external;

  function withdraw(
    IERC20 asset,
    uint256 amount,
    address to
  ) external returns (uint256);
}