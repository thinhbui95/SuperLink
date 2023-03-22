pragma solidity ^0.8.0;
import "./AaveeV2.sol";



 contract Coin98AaveeV2 is Aavee2{
    using SafeMath for uint256;

    struct SwapParam {
        uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        uint percent;
        bytes payload;
        uint256 networkFee;
    }
    constructor(
        uint16 _aaveeRefCode,
        address _aaveeLendingPool,
        address _aaveeWethGateway)
        Aavee2(_aaveeRefCode, _aaveeLendingPool, _aaveeWethGateway) {}

    function swap(uint amount0Out, uint amount1Out, address to, bytes memory data) external payable {
        SwapParam memory swapParam = abi.decode(data, (SwapParam));
        require(swapParam.index == 6, "Invalid Route");
        swapOnAaveeV2(
            swapParam.fromToken,
            swapParam.toToken,
            amount0Out,
            swapParam.payload
        );
        uint256 balance = swapParam.toToken.balanceOf(address(this));
        swapParam.toToken.transfer(to, balance);
    }
}