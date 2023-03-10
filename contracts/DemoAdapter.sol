// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./Helper.sol";
import "./library/Utils.sol";

interface PartnerSuperLink {
    function PARTNER_FEE() external view returns (uint256);
}

interface SwapAdapter {
    function swapUniV2(uint256 amount0Out, uint256 amount1Out, address to, bytes memory data) external payable;
    function swap(uint amount0Out, uint amount1Out, address to,  bytes memory data) external payable;
}

contract DemoAdapter is Ownable {
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




    struct SwapParam {
        uint8 index;
        IERC20 fromToken;
        IERC20 toToken;
        address targetExchange;
        uint percent;
        bytes payload;
        uint256 networkFee;
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
    struct SwapChain {
        address[] routes;
        uint256[] amount0Out;
        uint256[] amount1Out;
        uint256[] indexes;
        bytes[] data;
    }


    function swapRoutes(
        //address partner,
        uint256 fromAmout,
        address fromToken,
        address toToken,
        SwapChain memory swapChain
    ) external payable {
        require (msg.value >= fromAmout,"Not enough efficient");
        //require(Partners[partner].isActive, "SuperLink: Partner not active");
        uint256 routesSize = swapChain.routes.length;
        // address _toToken = toToken == address(0) ? address(0) : toToken;
        // address _fromToken = fromToken == address(0) ? address(0) : fromToken;
        for (uint256 i ; i<routesSize ; i++) {
            uint256 amount0Out = swapChain.amount0Out[i];
            uint256 amount1Out = swapChain.amount1Out[i];
            bytes memory data = swapChain.data[i];
            address to = i == (routesSize - 1) ? address(this) : swapChain.routes[i+1];
            if (i==0) {
                TransferHelper.onTransferFrom(fromToken,fromAmout,swapChain.routes[i]);
                
            }  
            if (i > 0) {
                if (swapChain.indexes[i] == 10) {
                    SwapAdapter(swapChain.routes[i]).swapUniV2(amount0Out,amount1Out,to, data);
                }else {
                    SwapAdapter(swapChain.routes[i]).swap(amount0Out,amount1Out,to, data);
                }
            }
        }

        // Claim token for each swap
        if (toToken == address(0)) {
            uint256 totalOutputAmount = IERC20(weth).balanceOf(address(this));
            TransferHelper.transferNativeToken(totalOutputAmount,msg.sender);
        } else {
            uint256 totalOutputAmount = IERC20(toToken).balanceOf(address(this));
            TransferHelper.transferERC20(toToken,totalOutputAmount,msg.sender);
        }

        // uint256 protocolFee = claimProtocol(totalOutputAmount);
        // uint256 returnAmount = claimPartner(partner, toToken, protocolFee);

    }

}
