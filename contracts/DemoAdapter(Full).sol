// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./Helper.sol";
import "./library/Utils.sol";
import "./CurveV2/Coin98CurveV2.sol";
import "./Uniswap/Coin98Uniswap(V2).sol";

interface PartnerSuperLink {
    function PARTNER_FEE() external view returns (uint256);
}
interface IExecutor {
    function execution (bytes memory data, address from, address toToken) external;
}

interface SwapAdapter {
    function swap(uint amount0Out, uint amount1Out, address to,  bytes memory data) external payable;
}

abstract contract EthReceiver {
    receive() external payable {
        // solhint-disable-next-line avoid-tx-origin
        require(msg.sender != tx.origin, "ETH deposit rejected");
    }
}

contract DemoAdapter1 is Ownable,  EthReceiver,ReentrancyGuard{
    using SafeMath for uint256;
     /// @notice Partner fee local pay for each swap (Use for C98 Finance only)
    uint256 public PARTNER_FEE = 80;
    /// @notice Protocol fee local pay for each swap
    uint256 public PROTOCOL_FEE = 10;
    uint256 private Percent = 10000;
    address public weth;
    constructor(address _weth) {
        weth = _weth;
    }

  
    /// @notice Claim Partner Fee event for notice to the partner when user swap and using partner UI
    event ClaimPartnerFee(
        address partner,
        address tokenOut,
        uint256 partnerFee
    );
    /// @notice Set new partner into SuperLink
    event SetPartner(string name, address partner);
    /// @notice Notice when deactive old partner
    event DeactivePartner(string name, address partner);
    /// @notice Set partner fee event for notice when change partner fee
    event SetPartnerFee(uint256 _partnerFee);
    /// @notice Set protocol fe event for notice when change protocol fee
    event SetProtocolFee(uint256 _protocolFee);

    /// @notice Partner registration in SuperLink system
    /// `isActive` Active or Deactive partner.
    /// `name` Partner's name.
    /// `registrationTime` Partner's registration time
    struct Partner {
        bool isActive;
        string name;
        uint256 registrationTime;
    }
        mapping(address => Partner) public Partners;


    /// @notice Setting partner for SuperLink
    /// @param _partner Address partner
    /// @param _name Partner's name.
    /// @param _isActive Status of partner
    function setPartner(
        address _partner,
        string memory _name,
        bool _isActive
    ) public onlyOwner {
        Partner storage partner = Partners[_partner];

        if (!_isActive) {
            require(partner.isActive, "SuperLink: Partner already deactive");
            partner.isActive = false;
            emit DeactivePartner(_name, _partner);
        } else {
            // Update information
            partner.isActive = _isActive;
            partner.name = _name;
            partner.registrationTime = block.timestamp;
            emit SetPartner(_name, _partner);
        }
    }

    /// @notice Set protocol fee pay for each swap
    /// @param _protocolFee Fee system pay for each swap
    function setProtocolFee(uint256 _protocolFee) external onlyOwner {
        require(
            _protocolFee > 0,
            "SuperLink: Fee must be a positive number and greater than zero"
        );
        PROTOCOL_FEE = _protocolFee;
        emit SetProtocolFee(_protocolFee);
    }

    /// @notice Set partner fee pay for each swap
    /// @param _partnerFee Fee partner local pay for each swap (Use for C98 Finance only)
    function setPartnerFee(uint256 _partnerFee) external onlyOwner {
        require(
            _partnerFee > 0,
            "SuperLink: Fee must be a positive number and greater than zero"
        );
        PARTNER_FEE = _partnerFee;
        emit SetPartnerFee(_partnerFee);
    }

    /// @notice Claim protocol fee for each swap
    /// @param _amount Protocol fee pay for each swap
    /// @return Amount received after deducting protocol fee
    function claimProtocol(uint256 _amount) internal view returns (uint256) {
        require(
            _amount > 0,
            "SuperLink: Amount must be a positive number and greater than zero"
        );
        return _amount.sub(_amount.mul(PROTOCOL_FEE).div(Percent));
    }

    /// @notice Charge partner fee for each swap in SuperLink
    /// Use local variable PARTNER_FEE when same address with SuperLink (C98 Finance use this)
    /// Another partner address will use variable from PartnerSuperLink contract address
    /// @param _partner Partner address for charge fee (Must registration in SuperLink)
    /// @param _tokenOut Use this token for charge partner fee
    /// @param _amount Swap amount received from sender
    /// @return Amount to return to user after deducting fee
    function claimPartner(
        address _partner,
        address _tokenOut,
        uint256 _amount
    ) internal returns (uint256) {
        require(
            _amount > 0,
            "SuperLink: Amount must be a positive number and greater than zero"
        );

        if (Partners[_partner].isActive) {
            bool isSystemFee = _partner == address(this);

            uint256 claimPartnerFee = _amount
                .mul(
                    isSystemFee
                        ? PARTNER_FEE
                        : PartnerSuperLink(_partner).PARTNER_FEE()
                )
                .div(Percent);

            // Transfer fee to partner
            if (!isSystemFee) {
                IERC20(_tokenOut).transfer(_partner, claimPartnerFee);
            }
            emit ClaimPartnerFee(_partner, _tokenOut, claimPartnerFee);
            return _amount.sub(claimPartnerFee);
        }
        return _amount;
    }
    struct SwapParam {
        //uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        //uint percent;
        bytes payload;
        //uint256 networkFee;
    }
    // function swapStraight(
    //     uint256[] memory fromToAmount,
    //     address fromToken,
    //     address toToken,
    //     SwapAdapter [] memory routers,
    //     bytes [] memory payloads,
    //     uint256[] memory amountOut // Only for uniswapV2 
    //     //uint256 minimumOut
    // ) external nonReentrant payable {
    //     if (fromToken == address(0)) {
    //         require (msg.value >= fromToAmount[0],"Not enough balance"); 
    //     }
    //     uint256 balanceInNextFrom = IERC20(fromToken).balanceOf(address(routers[0]));
    //     uint256 balanceToBeforeSwap = toToken == address(0) ? IERC20(weth).balanceOf(address(this)):IERC20(toToken).balanceOf(address(this));
    //     TransferHelper.onTransferFrom(fromToken,fromToAmount[0], address(routers[0]));
    //     uint256 sizeChain = routers.length;
    //     for (uint256 i; i< sizeChain; i++) {
    //         SwapParam memory swapparam = abi.decode(payloads[i], (SwapParam));
    //         uint256 balanceIn = swapparam.fromToken.balanceOf(address(routers[i]));
    //         uint256 realIn = balanceIn - balanceInNextFrom;
    //         address to = i == (sizeChain - 1) ? address(this) : address(routers[i+1]);
    //         balanceInNextFrom = i == (sizeChain - 1) ? 0 : swapparam.toToken.balanceOf(address(routers[i+1]));
    //         (bool success, ) = address(routers[i]).call(abi.encodeWithSelector(SwapAdapter.swap.selector,realIn, amountOut[i],to, payloads[i]));
    //         require(success, "failed call");

    //     }
    //     // Claim token for each swap
    //     uint256 totalOutputAmount = toToken == address(0) ? (IERC20(weth).balanceOf(address(this)) - balanceToBeforeSwap) : (IERC20(toToken).balanceOf(address(this)) - balanceToBeforeSwap);
    //     require(totalOutputAmount >= fromToAmount[1],"amountOut invalid");
    //     if (toToken == address(0)) {
    //         TransferHelper.transferNativeToken(totalOutputAmount,msg.sender);
    //     } else {
    //         TransferHelper.transferERC20(toToken,totalOutputAmount,msg.sender);
    //     }

    // }


    function swapRoutes(
        //address partner,
        uint256[] memory fromToAmount,
        address fromToken,
        address toToken,
        bytes memory data,
        //uint256 minimumOut,
        IExecutor executor

    ) external nonReentrant payable {
        if (fromToken == address(0)) {
            require (msg.value >= fromToAmount[0],"Not enough balance"); 
        }
        uint256 balanceToBeforeSwap = toToken == address(0) ? IERC20(weth).balanceOf(address(this)):IERC20(toToken).balanceOf(address(this));
        TransferHelper.onTransferFrom(fromToken,fromToAmount[0], address(executor));
        (bool success,) = address(executor).call(abi.encodeWithSelector(IExecutor.execution.selector,data,address(this),toToken));
        require(success, "Failed");
        

        // Claim token for each swap
        uint256 totalOutputAmount = toToken == address(0) ? (IERC20(weth).balanceOf(address(this)) - balanceToBeforeSwap) : (IERC20(toToken).balanceOf(address(this)) - balanceToBeforeSwap);
        require(totalOutputAmount >= fromToAmount[1],"amountOut invalid");
        if (toToken == address(0)) {
            TransferHelper.transferNativeToken(totalOutputAmount,msg.sender);
        } else {
            TransferHelper.transferERC20(toToken,totalOutputAmount,msg.sender);
        }

        // uint256 protocolFee = claimProtocol(totalOutputAmount);
        // uint256 returnAmount = claimPartner(partner, toToken, protocolFee);

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
