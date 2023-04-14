// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library TransferHelper {

    uint256 private constant _TRANSFER_FROM_CALL_SELECTOR_32 =
        0x23b872dd00000000000000000000000000000000000000000000000000000000;

    uint256 private constant _WETH_DEPOSIT_CALL_SELECTOR_32 =
        0xd0e30db000000000000000000000000000000000000000000000000000000000;

    // uint256 private constant _WETH =
    //     0x0000000000000000000000005545153CCFcA01fbd7Dd11C0b23ba694D9509A6F; //Heco

    uint256 private constant _WETH =
        0x000000000000000000000000B4FBF271143F4FBf7B91A5ded31805e42b2208d6 ; //Goerli ETH
    // uint256 private constant _WETH =
    //     0x000000000000000000000000ae13d989daC2f0dEbFf460aC112a837C89BAa7cd ; //BSC Testnet
    
    uint256 private constant _ERC20_TRANSFER_CALL_SELECTOR_32 =
        0xa9059cbb00000000000000000000000000000000000000000000000000000000;
    uint256 private constant _WETH_WITHDRAW_CALL_SELECTOR_32 =
        0x2e1a7d4d00000000000000000000000000000000000000000000000000000000;

    /// @notice Transfer ERC20 token and Wrapped token like WETH or WBNB using assembly code
    /// @param _token Use this token for transfer
    /// @param _amount Amount to transfer
    /// @param _receiver Address to receive
    function transferERC20(
        address _token,
        uint256 _amount,
        address _receiver
    ) internal {
        assembly {
            let emptyPtr := mload(0x40)
            mstore(0x40, add(emptyPtr, 0xc0))

            function reRevert() {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
            mstore(emptyPtr, _ERC20_TRANSFER_CALL_SELECTOR_32)
            mstore(add(emptyPtr, 0x4), _receiver)
            mstore(add(emptyPtr, 0x24), _amount)
            if iszero(call(gas(), _token, 0, emptyPtr, 0x44, 0, 0)) {
                reRevert()
            }

        }
    }


    /// @notice Transfer native token such us ETH, BNB from wrapped token like WETH, WBNB using assembly code
    /// @param _amount Amount to transfer
    /// @param _receiver Address to receive
    function transferNativeToken(
        uint256 _amount,
        address _receiver
    ) internal {
        assembly {
            let emptyPtr := mload(0x40)
            mstore(0x40, add(emptyPtr, 0xc0))

            function reRevert() {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
            mstore(emptyPtr, _WETH_WITHDRAW_CALL_SELECTOR_32)
            mstore(add(emptyPtr, 0x04), _amount)
            if iszero(call(gas(), _WETH, 0, emptyPtr, 0x24, 0, 0)) {
                reRevert()
            }

            if iszero(call(gas(), _receiver, _amount, 0, 0, 0, 0)) {
                reRevert()
            }
           
        }
    }
    /// @notice Transfer from ERC20 token and Wrapped token like WETH or WBNB using assembly code
    /// @param _token Use this token for transfer from
    /// @param _amount Amount to transfer from
    /// @param _receiver Address to receive transfer from
    function onTransferFrom(
        address _token,
        uint256 _amount,
        address _receiver
    ) internal {
        assembly {
            function reRevert() {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }

            function revertWithReason(m, len) {
                mstore(
                    0,
                    0x08c379a000000000000000000000000000000000000000000000000000000000
                )
                mstore(
                    0x20,
                    0x0000002000000000000000000000000000000000000000000000000000000000
                )
                mstore(0x40, m)
                revert(0, len)
            }

            let emptyPtr := mload(0x40)
            mstore(0x40, add(emptyPtr, 0xc0))

            switch _token
            case 0 {
                mstore(emptyPtr, _WETH_DEPOSIT_CALL_SELECTOR_32)
                if iszero(call(gas(), _WETH, _amount, emptyPtr, 0x4, 0, 0)) {
                    reRevert()
                }

                mstore(emptyPtr, _ERC20_TRANSFER_CALL_SELECTOR_32)
                mstore(add(emptyPtr, 0x4), _receiver)
                mstore(add(emptyPtr, 0x24), _amount)
                if iszero(call(gas(), _WETH, 0, emptyPtr, 0x44, 0, 0)) {
                    reRevert()
                }
            }
            default {
                if callvalue() {
                    revertWithReason(
                        0x00000011696e76616c6964206d73672e76616c75650000000000000000000000,
                        0x55
                    ) // "Invalid sender msg.value"
                }

                mstore(emptyPtr, _TRANSFER_FROM_CALL_SELECTOR_32)
                mstore(add(emptyPtr, 0x4), caller())
                mstore(add(emptyPtr, 0x24), _receiver)
                mstore(add(emptyPtr, 0x44), _amount)
                if iszero(call(gas(), _token, 0, emptyPtr, 0x64, 0, 0)) {
                    reRevert()
                }
            }

        }
    }
}
    library SafeCast {
        /// @notice Cast a uint256 to a int256, revert on overflow
        /// @param y The uint256 to be casted
        /// @return z The casted integer, now type int256
        function toInt256(uint256 y) internal pure returns (int256 z) {
            require(y < 2**255);
            z = int256(y);
        }
    }