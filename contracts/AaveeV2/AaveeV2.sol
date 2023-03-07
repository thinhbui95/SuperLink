pragma solidity ^0.8.0;
import "../library/Utils.sol";
import "../interface/IWETHGateway.sol";
import "../interface/IAaveLendingPool.sol";


contract Aavee2 {

  struct AaveeData {
    address aToken;
  }

  uint16 public immutable refCode;
  address public immutable  lendingPool;
  address public immutable  wethGateway;

  constructor (
    uint16 _refCode,
    address _lendingPool,
    address _wethGateway
  )
    public
  {
    refCode = _refCode;
    lendingPool = _lendingPool;
    wethGateway = _wethGateway;
  }

  function swapOnAaveeV2(
    IERC20 fromToken,
    IERC20 toToken,
    uint256 fromAmount,
    bytes memory payload
  )
    internal
  {
    _swapOnAaveeV2(
      fromToken,
      toToken,
      fromAmount,
      payload
    );
  }

  function buyOnAaveeV2(
    IERC20 fromToken,
    IERC20 toToken,
    uint256 fromAmount,
    bytes memory payload
  )
    internal
  {
    _swapOnAaveeV2(
      fromToken,
      toToken,
      fromAmount,
      payload
    );
  }

  function _swapOnAaveeV2(
    IERC20 fromToken,
    IERC20 toToken,
    uint256 fromAmount,
    bytes memory payload
  )
    private
  {
    AaveeData memory data = abi.decode(payload, (AaveeData));

    if (address(fromToken) == address(data.aToken)) {
      if (address(toToken) == Utils.ethAddress()) {
        Utils.approve(wethGateway, address(fromToken), fromAmount);
        IWETHGateway(wethGateway).withdrawETH(lendingPool, fromAmount, address(this));
      }
      else {
        Utils.approve(lendingPool, address(fromToken), fromAmount);
        IAaveLendingPool(lendingPool).withdraw(toToken, fromAmount, address(this));
      }
    }
    else if (address(toToken) == address(data.aToken)) {
      if (address(fromToken) == Utils.ethAddress()) {
        IWETHGateway(wethGateway).depositETH{value : fromAmount}(lendingPool, address(this), refCode);
      }
      else {
        Utils.approve(lendingPool, address(fromToken), fromAmount);
        IAaveLendingPool(lendingPool).deposit(fromToken, fromAmount, address(this), refCode);
      }
    }
    else {
      revert("Invalid aToken");
    }
  }
}
