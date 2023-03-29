// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// /**
//  * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
//  * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
//  *
//  * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
//  * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
//  * need to send a transaction, and thus is not required to hold Ether at all.
//  */
// interface IERC20Permit {
//     /**
//      * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
//      * given ``owner``'s signed approval.
//      *
//      * IMPORTANT: The same issues {IERC20-approve} has related to transaction
//      * ordering also apply here.
//      *
//      * Emits an {Approval} event.
//      *
//      * Requirements:
//      *
//      * - `spender` cannot be the zero address.
//      * - `deadline` must be a timestamp in the future.
//      * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
//      * over the EIP712-formatted function arguments.
//      * - the signature must use ``owner``'s current nonce (see {nonces}).
//      *
//      * For more information on the signature format, see the
//      * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
//      * section].
//      */
//     function permit(
//         address owner,
//         address spender,
//         uint256 value,
//         uint256 deadline,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) external;

//     /**
//      * @dev Returns the current nonce for `owner`. This value must be
//      * included whenever a signature is generated for {permit}.
//      *
//      * Every successful call to {permit} increases ``owner``'s nonce by one. This
//      * prevents a signature from being used multiple times.
//      */
//     function nonces(address owner) external view returns (uint256);

//     /**
//      * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
//      */
//     // solhint-disable-next-line func-name-mixedcase
//     function DOMAIN_SEPARATOR() external view returns (bytes32);
// }


// // File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.8.2

// // SPDX-License-Identifier: MIT
// // OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

// pragma solidity ^0.8.0;

// /**
//  * @dev Interface of the ERC20 standard as defined in the EIP.
//  */
// interface IERC20 {
//     /**
//      * @dev Emitted when `value` tokens are moved from one account (`from`) to
//      * another (`to`).
//      *
//      * Note that `value` may be zero.
//      */
//     event Transfer(address indexed from, address indexed to, uint256 value);

//     /**
//      * @dev Emitted when the allowance of a `spender` for an `owner` is set by
//      * a call to {approve}. `value` is the new allowance.
//      */
//     event Approval(address indexed owner, address indexed spender, uint256 value);

//     /**
//      * @dev Returns the amount of tokens in existence.
//      */
//     function totalSupply() external view returns (uint256);

//     /**
//      * @dev Returns the amount of tokens owned by `account`.
//      */
//     function balanceOf(address account) external view returns (uint256);

//     /**
//      * @dev Moves `amount` tokens from the caller's account to `to`.
//      *
//      * Returns a boolean value indicating whether the operation succeeded.
//      *
//      * Emits a {Transfer} event.
//      */
//     function transfer(address to, uint256 amount) external returns (bool);

//     /**
//      * @dev Returns the remaining number of tokens that `spender` will be
//      * allowed to spend on behalf of `owner` through {transferFrom}. This is
//      * zero by default.
//      *
//      * This value changes when {approve} or {transferFrom} are called.
//      */
//     function allowance(address owner, address spender) external view returns (uint256);

//     /**
//      * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
//      *
//      * Returns a boolean value indicating whether the operation succeeded.
//      *
//      * IMPORTANT: Beware that changing an allowance with this method brings the risk
//      * that someone may use both the old and the new allowance by unfortunate
//      * transaction ordering. One possible solution to mitigate this race
//      * condition is to first reduce the spender's allowance to 0 and set the
//      * desired value afterwards:
//      * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
//      *
//      * Emits an {Approval} event.
//      */
//     function approve(address spender, uint256 amount) external returns (bool);

//     /**
//      * @dev Moves `amount` tokens from `from` to `to` using the
//      * allowance mechanism. `amount` is then deducted from the caller's
//      * allowance.
//      *
//      * Returns a boolean value indicating whether the operation succeeded.
//      *
//      * Emits a {Transfer} event.
//      */
//     function transferFrom(
//         address from,
//         address to,
//         uint256 amount
//     ) external returns (bool);
// }


// // File @openzeppelin/contracts/utils/Address.sol@v4.8.2

// // SPDX-License-Identifier: MIT
// // OpenZeppelin Contracts (last updated v4.8.0) (utils/Address.sol)

// pragma solidity ^0.8.1;

// /**
//  * @dev Collection of functions related to the address type
//  */
// library Address {
//     /**
//      * @dev Returns true if `account` is a contract.
//      *
//      * [IMPORTANT]
//      * ====
//      * It is unsafe to assume that an address for which this function returns
//      * false is an externally-owned account (EOA) and not a contract.
//      *
//      * Among others, `isContract` will return false for the following
//      * types of addresses:
//      *
//      *  - an externally-owned account
//      *  - a contract in construction
//      *  - an address where a contract will be created
//      *  - an address where a contract lived, but was destroyed
//      * ====
//      *
//      * [IMPORTANT]
//      * ====
//      * You shouldn't rely on `isContract` to protect against flash loan attacks!
//      *
//      * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
//      * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
//      * constructor.
//      * ====
//      */
//     function isContract(address account) internal view returns (bool) {
//         // This method relies on extcodesize/address.code.length, which returns 0
//         // for contracts in construction, since the code is only stored at the end
//         // of the constructor execution.

//         return account.code.length > 0;
//     }

//     /**
//      * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
//      * `recipient`, forwarding all available gas and reverting on errors.
//      *
//      * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
//      * of certain opcodes, possibly making contracts go over the 2300 gas limit
//      * imposed by `transfer`, making them unable to receive funds via
//      * `transfer`. {sendValue} removes this limitation.
//      *
//      * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
//      *
//      * IMPORTANT: because control is transferred to `recipient`, care must be
//      * taken to not create reentrancy vulnerabilities. Consider using
//      * {ReentrancyGuard} or the
//      * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
//      */
//     function sendValue(address payable recipient, uint256 amount) internal {
//         require(address(this).balance >= amount, "Address: insufficient balance");

//         (bool success, ) = recipient.call{value: amount}("");
//         require(success, "Address: unable to send value, recipient may have reverted");
//     }

//     /**
//      * @dev Performs a Solidity function call using a low level `call`. A
//      * plain `call` is an unsafe replacement for a function call: use this
//      * function instead.
//      *
//      * If `target` reverts with a revert reason, it is bubbled up by this
//      * function (like regular Solidity function calls).
//      *
//      * Returns the raw returned data. To convert to the expected return value,
//      * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
//      *
//      * Requirements:
//      *
//      * - `target` must be a contract.
//      * - calling `target` with `data` must not revert.
//      *
//      * _Available since v3.1._
//      */
//     function functionCall(address target, bytes memory data) internal returns (bytes memory) {
//         return functionCallWithValue(target, data, 0, "Address: low-level call failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
//      * `errorMessage` as a fallback revert reason when `target` reverts.
//      *
//      * _Available since v3.1._
//      */
//     function functionCall(
//         address target,
//         bytes memory data,
//         string memory errorMessage
//     ) internal returns (bytes memory) {
//         return functionCallWithValue(target, data, 0, errorMessage);
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
//      * but also transferring `value` wei to `target`.
//      *
//      * Requirements:
//      *
//      * - the calling contract must have an ETH balance of at least `value`.
//      * - the called Solidity function must be `payable`.
//      *
//      * _Available since v3.1._
//      */
//     function functionCallWithValue(
//         address target,
//         bytes memory data,
//         uint256 value
//     ) internal returns (bytes memory) {
//         return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
//      * with `errorMessage` as a fallback revert reason when `target` reverts.
//      *
//      * _Available since v3.1._
//      */
//     function functionCallWithValue(
//         address target,
//         bytes memory data,
//         uint256 value,
//         string memory errorMessage
//     ) internal returns (bytes memory) {
//         require(address(this).balance >= value, "Address: insufficient balance for call");
//         (bool success, bytes memory returndata) = target.call{value: value}(data);
//         return verifyCallResultFromTarget(target, success, returndata, errorMessage);
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
//      * but performing a static call.
//      *
//      * _Available since v3.3._
//      */
//     function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
//         return functionStaticCall(target, data, "Address: low-level static call failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
//      * but performing a static call.
//      *
//      * _Available since v3.3._
//      */
//     function functionStaticCall(
//         address target,
//         bytes memory data,
//         string memory errorMessage
//     ) internal view returns (bytes memory) {
//         (bool success, bytes memory returndata) = target.staticcall(data);
//         return verifyCallResultFromTarget(target, success, returndata, errorMessage);
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
//      * but performing a delegate call.
//      *
//      * _Available since v3.4._
//      */
//     function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
//         return functionDelegateCall(target, data, "Address: low-level delegate call failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
//      * but performing a delegate call.
//      *
//      * _Available since v3.4._
//      */
//     function functionDelegateCall(
//         address target,
//         bytes memory data,
//         string memory errorMessage
//     ) internal returns (bytes memory) {
//         (bool success, bytes memory returndata) = target.delegatecall(data);
//         return verifyCallResultFromTarget(target, success, returndata, errorMessage);
//     }

//     /**
//      * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
//      * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
//      *
//      * _Available since v4.8._
//      */
//     function verifyCallResultFromTarget(
//         address target,
//         bool success,
//         bytes memory returndata,
//         string memory errorMessage
//     ) internal view returns (bytes memory) {
//         if (success) {
//             if (returndata.length == 0) {
//                 // only check isContract if the call was successful and the return data is empty
//                 // otherwise we already know that it was a contract
//                 require(isContract(target), "Address: call to non-contract");
//             }
//             return returndata;
//         } else {
//             _revert(returndata, errorMessage);
//         }
//     }

//     /**
//      * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
//      * revert reason or using the provided one.
//      *
//      * _Available since v4.3._
//      */
//     function verifyCallResult(
//         bool success,
//         bytes memory returndata,
//         string memory errorMessage
//     ) internal pure returns (bytes memory) {
//         if (success) {
//             return returndata;
//         } else {
//             _revert(returndata, errorMessage);
//         }
//     }

//     function _revert(bytes memory returndata, string memory errorMessage) private pure {
//         // Look for revert reason and bubble it up if present
//         if (returndata.length > 0) {
//             // The easiest way to bubble the revert reason is using memory via assembly
//             /// @solidity memory-safe-assembly
//             assembly {
//                 let returndata_size := mload(returndata)
//                 revert(add(32, returndata), returndata_size)
//             }
//         } else {
//             revert(errorMessage);
//         }
//     }
// }


// // File @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol@v4.8.2

// // SPDX-License-Identifier: MIT
// // OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/utils/SafeERC20.sol)

// pragma solidity ^0.8.0;



// /**
//  * @title SafeERC20
//  * @dev Wrappers around ERC20 operations that throw on failure (when the token
//  * contract returns false). Tokens that return no value (and instead revert or
//  * throw on failure) are also supported, non-reverting calls are assumed to be
//  * successful.
//  * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
//  * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
//  */
// library SafeERC20 {
//     using Address for address;

//     function safeTransfer(
//         IERC20 token,
//         address to,
//         uint256 value
//     ) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
//     }

//     function safeTransferFrom(
//         IERC20 token,
//         address from,
//         address to,
//         uint256 value
//     ) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
//     }

//     /**
//      * @dev Deprecated. This function has issues similar to the ones found in
//      * {IERC20-approve}, and its usage is discouraged.
//      *
//      * Whenever possible, use {safeIncreaseAllowance} and
//      * {safeDecreaseAllowance} instead.
//      */
//     function safeApprove(
//         IERC20 token,
//         address spender,
//         uint256 value
//     ) internal {
//         // safeApprove should only be called when setting an initial allowance,
//         // or when resetting it to zero. To increase and decrease it, use
//         // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
//         require(
//             (value == 0) || (token.allowance(address(this), spender) == 0),
//             "SafeERC20: approve from non-zero to non-zero allowance"
//         );
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
//     }

//     function safeIncreaseAllowance(
//         IERC20 token,
//         address spender,
//         uint256 value
//     ) internal {
//         uint256 newAllowance = token.allowance(address(this), spender) + value;
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//     }

//     function safeDecreaseAllowance(
//         IERC20 token,
//         address spender,
//         uint256 value
//     ) internal {
//         unchecked {
//             uint256 oldAllowance = token.allowance(address(this), spender);
//             require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
//             uint256 newAllowance = oldAllowance - value;
//             _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//         }
//     }

//     function safePermit(
//         IERC20Permit token,
//         address owner,
//         address spender,
//         uint256 value,
//         uint256 deadline,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) internal {
//         uint256 nonceBefore = token.nonces(owner);
//         token.permit(owner, spender, value, deadline, v, r, s);
//         uint256 nonceAfter = token.nonces(owner);
//         require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
//     }

//     /**
//      * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
//      * on the return value: the return value is optional (but if data is returned, it must not be false).
//      * @param token The token targeted by the call.
//      * @param data The call data (encoded using abi.encode or one of its variants).
//      */
//     function _callOptionalReturn(IERC20 token, bytes memory data) private {
//         // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
//         // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
//         // the target address contains contract code and also asserts for success in the low-level call.

//         bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
//         if (returndata.length > 0) {
//             // Return data is optional
//             require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
//         }
//     }
// }


// // File contracts/interface/ICurveV2Pool.sol

// pragma solidity ^0.8.0;

// interface ICurveV2Pool {
//     function exchange_underlying(uint256 i, uint256 j, uint256 dx, uint256 minDy) external;
//     function exchange(uint256 i, uint256 j, uint256 dx, uint256 minDy) external;
// }


// // File contracts/interface/IWETH.sol

// pragma solidity ^0.8.0;

// abstract contract IWETH is IERC20 {
//     function deposit() external virtual payable;
//     function withdraw(uint256 amount) external virtual;
// }


// // File @openzeppelin/contracts/utils/math/SafeMath.sol@v4.8.2

// // SPDX-License-Identifier: MIT
// // OpenZeppelin Contracts (last updated v4.6.0) (utils/math/SafeMath.sol)

// pragma solidity ^0.8.0;

// // CAUTION
// // This version of SafeMath should only be used with Solidity 0.8 or later,
// // because it relies on the compiler's built in overflow checks.

// /**
//  * @dev Wrappers over Solidity's arithmetic operations.
//  *
//  * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
//  * now has built in overflow checking.
//  */
// library SafeMath {
//     /**
//      * @dev Returns the addition of two unsigned integers, with an overflow flag.
//      *
//      * _Available since v3.4._
//      */
//     function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
//         unchecked {
//             uint256 c = a + b;
//             if (c < a) return (false, 0);
//             return (true, c);
//         }
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
//      *
//      * _Available since v3.4._
//      */
//     function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
//         unchecked {
//             if (b > a) return (false, 0);
//             return (true, a - b);
//         }
//     }

//     /**
//      * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
//      *
//      * _Available since v3.4._
//      */
//     function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
//         unchecked {
//             // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
//             // benefit is lost if 'b' is also tested.
//             // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
//             if (a == 0) return (true, 0);
//             uint256 c = a * b;
//             if (c / a != b) return (false, 0);
//             return (true, c);
//         }
//     }

//     /**
//      * @dev Returns the division of two unsigned integers, with a division by zero flag.
//      *
//      * _Available since v3.4._
//      */
//     function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
//         unchecked {
//             if (b == 0) return (false, 0);
//             return (true, a / b);
//         }
//     }

//     /**
//      * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
//      *
//      * _Available since v3.4._
//      */
//     function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
//         unchecked {
//             if (b == 0) return (false, 0);
//             return (true, a % b);
//         }
//     }

//     /**
//      * @dev Returns the addition of two unsigned integers, reverting on
//      * overflow.
//      *
//      * Counterpart to Solidity's `+` operator.
//      *
//      * Requirements:
//      *
//      * - Addition cannot overflow.
//      */
//     function add(uint256 a, uint256 b) internal pure returns (uint256) {
//         return a + b;
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, reverting on
//      * overflow (when the result is negative).
//      *
//      * Counterpart to Solidity's `-` operator.
//      *
//      * Requirements:
//      *
//      * - Subtraction cannot overflow.
//      */
//     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
//         return a - b;
//     }

//     /**
//      * @dev Returns the multiplication of two unsigned integers, reverting on
//      * overflow.
//      *
//      * Counterpart to Solidity's `*` operator.
//      *
//      * Requirements:
//      *
//      * - Multiplication cannot overflow.
//      */
//     function mul(uint256 a, uint256 b) internal pure returns (uint256) {
//         return a * b;
//     }

//     /**
//      * @dev Returns the integer division of two unsigned integers, reverting on
//      * division by zero. The result is rounded towards zero.
//      *
//      * Counterpart to Solidity's `/` operator.
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function div(uint256 a, uint256 b) internal pure returns (uint256) {
//         return a / b;
//     }

//     /**
//      * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
//      * reverting when dividing by zero.
//      *
//      * Counterpart to Solidity's `%` operator. This function uses a `revert`
//      * opcode (which leaves remaining gas untouched) while Solidity uses an
//      * invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function mod(uint256 a, uint256 b) internal pure returns (uint256) {
//         return a % b;
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
//      * overflow (when the result is negative).
//      *
//      * CAUTION: This function is deprecated because it requires allocating memory for the error
//      * message unnecessarily. For custom revert reasons use {trySub}.
//      *
//      * Counterpart to Solidity's `-` operator.
//      *
//      * Requirements:
//      *
//      * - Subtraction cannot overflow.
//      */
//     function sub(
//         uint256 a,
//         uint256 b,
//         string memory errorMessage
//     ) internal pure returns (uint256) {
//         unchecked {
//             require(b <= a, errorMessage);
//             return a - b;
//         }
//     }

//     /**
//      * @dev Returns the integer division of two unsigned integers, reverting with custom message on
//      * division by zero. The result is rounded towards zero.
//      *
//      * Counterpart to Solidity's `/` operator. Note: this function uses a
//      * `revert` opcode (which leaves remaining gas untouched) while Solidity
//      * uses an invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function div(
//         uint256 a,
//         uint256 b,
//         string memory errorMessage
//     ) internal pure returns (uint256) {
//         unchecked {
//             require(b > 0, errorMessage);
//             return a / b;
//         }
//     }

//     /**
//      * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
//      * reverting with custom message when dividing by zero.
//      *
//      * CAUTION: This function is deprecated because it requires allocating memory for the error
//      * message unnecessarily. For custom revert reasons use {tryMod}.
//      *
//      * Counterpart to Solidity's `%` operator. This function uses a `revert`
//      * opcode (which leaves remaining gas untouched) while Solidity uses an
//      * invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function mod(
//         uint256 a,
//         uint256 b,
//         string memory errorMessage
//     ) internal pure returns (uint256) {
//         unchecked {
//             require(b > 0, errorMessage);
//             return a % b;
//         }
//     }
// }


// // File contracts/Helper.sol

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// library TransferHelper {

//     uint256 private constant _TRANSFER_FROM_CALL_SELECTOR_32 =
//         0x23b872dd00000000000000000000000000000000000000000000000000000000;

//     uint256 private constant _WETH_DEPOSIT_CALL_SELECTOR_32 =
//         0xd0e30db000000000000000000000000000000000000000000000000000000000;

//     // uint256 private constant _WETH =
//     //     0x0000000000000000000000005545153CCFcA01fbd7Dd11C0b23ba694D9509A6F; //Heco

//     // uint256 private constant _WETH =
//         // 0x000000000000000000000000B4FBF271143F4FBf7B91A5ded31805e42b2208d6 ; //Goerli ETH
//     uint256 private constant _WETH =
//         0x000000000000000000000000ae13d989daC2f0dEbFf460aC112a837C89BAa7cd ; //BSC Testnet
    
//     uint256 private constant _ERC20_TRANSFER_CALL_SELECTOR_32 =
//         0xa9059cbb00000000000000000000000000000000000000000000000000000000;
//     uint256 private constant _WETH_WITHDRAW_CALL_SELECTOR_32 =
//         0x2e1a7d4d00000000000000000000000000000000000000000000000000000000;

//     /// @notice Transfer ERC20 token and Wrapped token like WETH or WBNB using assembly code
//     /// @param _token Use this token for transfer
//     /// @param _amount Amount to transfer
//     /// @param _receiver Address to receive
//     function transferERC20(
//         address _token,
//         uint256 _amount,
//         address _receiver
//     ) internal {
//         assembly {
//             let emptyPtr := mload(0x40)
//             mstore(0x40, add(emptyPtr, 0xc0))

//             function reRevert() {
//                 returndatacopy(0, 0, returndatasize())
//                 revert(0, returndatasize())
//             }
//             mstore(emptyPtr, _ERC20_TRANSFER_CALL_SELECTOR_32)
//             mstore(add(emptyPtr, 0x4), _receiver)
//             mstore(add(emptyPtr, 0x24), _amount)
//             if iszero(call(gas(), _token, 0, emptyPtr, 0x44, 0, 0)) {
//                 reRevert()
//             }

//         }
//     }


//     /// @notice Transfer native token such us ETH, BNB from wrapped token like WETH, WBNB using assembly code
//     /// @param _amount Amount to transfer
//     /// @param _receiver Address to receive
//     function transferNativeToken(
//         uint256 _amount,
//         address _receiver
//     ) internal {
//         assembly {
//             let emptyPtr := mload(0x40)
//             mstore(0x40, add(emptyPtr, 0xc0))

//             function reRevert() {
//                 returndatacopy(0, 0, returndatasize())
//                 revert(0, returndatasize())
//             }
//             mstore(emptyPtr, _WETH_WITHDRAW_CALL_SELECTOR_32)
//             mstore(add(emptyPtr, 0x04), _amount)
//             if iszero(call(gas(), _WETH, 0, emptyPtr, 0x24, 0, 0)) {
//                 reRevert()
//             }

//             if iszero(call(gas(), _receiver, _amount, 0, 0, 0, 0)) {
//                 reRevert()
//             }
           
//         }
//     }
//     /// @notice Transfer from ERC20 token and Wrapped token like WETH or WBNB using assembly code
//     /// @param _token Use this token for transfer from
//     /// @param _amount Amount to transfer from
//     /// @param _receiver Address to receive transfer from
//     function onTransferFrom(
//         address _token,
//         uint256 _amount,
//         address _receiver
//     ) internal {
//         assembly {
//             function reRevert() {
//                 returndatacopy(0, 0, returndatasize())
//                 revert(0, returndatasize())
//             }

//             function revertWithReason(m, len) {
//                 mstore(
//                     0,
//                     0x08c379a000000000000000000000000000000000000000000000000000000000
//                 )
//                 mstore(
//                     0x20,
//                     0x0000002000000000000000000000000000000000000000000000000000000000
//                 )
//                 mstore(0x40, m)
//                 revert(0, len)
//             }

//             let emptyPtr := mload(0x40)
//             mstore(0x40, add(emptyPtr, 0xc0))

//             switch _token
//             case 0 {
//                 mstore(emptyPtr, _WETH_DEPOSIT_CALL_SELECTOR_32)
//                 if iszero(call(gas(), _WETH, _amount, emptyPtr, 0x4, 0, 0)) {
//                     reRevert()
//                 }

//                 mstore(emptyPtr, _ERC20_TRANSFER_CALL_SELECTOR_32)
//                 mstore(add(emptyPtr, 0x4), _receiver)
//                 mstore(add(emptyPtr, 0x24), _amount)
//                 if iszero(call(gas(), _WETH, 0, emptyPtr, 0x44, 0, 0)) {
//                     reRevert()
//                 }
//             }
//             default {
//                 if callvalue() {
//                     revertWithReason(
//                         0x00000011696e76616c6964206d73672e76616c75650000000000000000000000,
//                         0x55
//                     ) // "Invalid sender msg.value"
//                 }

//                 mstore(emptyPtr, _TRANSFER_FROM_CALL_SELECTOR_32)
//                 mstore(add(emptyPtr, 0x4), caller())
//                 mstore(add(emptyPtr, 0x24), _receiver)
//                 mstore(add(emptyPtr, 0x44), _amount)
//                 if iszero(call(gas(), _token, 0, emptyPtr, 0x64, 0, 0)) {
//                     reRevert()
//                 }
//             }

//         }
//     }
// }


// // File contracts/library/Utils.sol

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;
// pragma experimental ABIEncoderV2;



// // interface IERC20Permit {
// //     function permit(address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
// // }

// library Utils {
//     using SafeMath for uint256;
//     using SafeERC20 for IERC20;

//     address constant ETH_ADDRESS = address(
//         0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
//     );
    
//     uint256 constant MAX_UINT = type(uint256).max;

//     /**
//    * @param fromToken Address of the source token
//    * @param fromAmount Amount of source tokens to be swapped
//    * @param toAmount Minimum destination token amount expected out of this swap
//    * @param expectedAmount Expected amount of destination tokens without slippage
//    * @param beneficiary Beneficiary address
//    * 0 then 100% will be transferred to beneficiary. Pass 10000 for 100%
//    * @param path Route to be taken for this swap to take place

//    */
//     struct SellData {
//         address fromToken;
//         uint256 fromAmount;
//         uint256 toAmount;
//         uint256 expectedAmount;
//         address payable beneficiary;
//         Utils.Path[] path;
//         address payable partner;
//         uint256 feePercent;
//         bytes permit;
//         uint256 deadline;
//         bytes16 uuid;
//     }

//     struct MegaSwapSellData {
//         address fromToken;
//         uint256 fromAmount;
//         uint256 toAmount;
//         uint256 expectedAmount;
//         address payable beneficiary;
//         Utils.MegaSwapPath[] path;
//         address payable partner;
//         uint256 feePercent;
//         bytes permit;
//         uint256 deadline;
//         bytes16 uuid;
//     }

//     struct SimpleData {
//         address fromToken;
//         address toToken;
//         uint256 fromAmount;
//         uint256 toAmount;
//         uint256 expectedAmount;
//         address[] callees;
//         bytes exchangeData;
//         uint256[] startIndexes;
//         uint256[] values;
//         address payable beneficiary;
//         address payable partner;
//         uint256 feePercent;
//         bytes permit;
//         uint256 deadline;
//         bytes16 uuid;
//     }

//     struct Adapter {
//         address payable adapter;
//         uint256 percent;
//         uint256 networkFee;
//         Route[] route;
//     }

//     struct Route {
//         uint256 index;//Adapter at which index needs to be used
//         address targetExchange;
//         uint percent;
//         bytes payload;
//         uint256 networkFee;//Network fee is associated with 0xv3 trades
//     }

//     struct MegaSwapPath {
//         uint256 fromAmountPercent;
//         Path[] path;
//     }

//     struct Path {
//         address to;
//         uint256 totalNetworkFee;//Network fee is associated with 0xv3 trades
//         Adapter[] adapters;
//     }

//     function ethAddress() internal pure returns (address) {return ETH_ADDRESS;}

//     function maxUint() internal pure returns (uint256) {return MAX_UINT;}

//     function approve(
//         address addressToApprove,
//         address token,
//         uint256 amount
//     ) internal {
//         if (token != ETH_ADDRESS) {
//             IERC20 _token = IERC20(token);

//             uint allowance = _token.allowance(address(this), addressToApprove);

//             if (allowance < amount) {
//                 _token.safeApprove(addressToApprove, 0);
//                 _token.safeIncreaseAllowance(addressToApprove, MAX_UINT);
//             }
//         }
//     }

//     function transferTokens(
//         address token,
//         address payable destination,
//         uint256 amount
//     )
//     internal
//     {
//         if (amount > 0) {
//             if (token == ETH_ADDRESS) {
//                 (bool result, ) = destination.call{value: amount, gas: 10000}("");
//                 require(result, "Failed to transfer Ether");
//             } else {
          
//                 TransferHelper.transferERC20(token, amount, destination);
            
//             }
//         }

//     }

//     function tokenBalance(
//         address token,
//         address account
//     )
//     internal
//     view
//     returns (uint256)
//     {
//         if (token == ETH_ADDRESS) {
//             return account.balance;
//         } else {
//             return IERC20(token).balanceOf(account);
//         }
//     }

//     // function permit(
//     //     address token,
//     //     bytes memory permit
//     // )
//     //     internal
//     // {
//     //     if (permit.length == 32 * 7) {
//     //         (bool success,) = token.call(abi.encodePacked(IERC20Permit.permit.selector, permit));
//     //         require(success, "Permit failed");
//     //     }
//     // }

// }


// // File contracts/CurveV2/CurveV2.sol

// pragma solidity ^0.8.0;



// abstract contract CurveV2 {

//     struct CurveV2Data {
//         uint256 i;
//         uint256 j;
//         bool underlyingSwap;
//     }

//     constructor () {}

//     function swapOnCurveV2(
//         IERC20 fromToken,
//         IERC20 toToken,
//         uint256 fromAmount,
//         address exchange,
//         bytes memory payload
//     )
//     internal

//     {

//         CurveV2Data memory curveV2Data = abi.decode(payload, (CurveV2Data));

//         address _fromToken = address(fromToken);

//         Utils.approve(address(exchange), address(_fromToken), fromAmount);
//         if (curveV2Data.underlyingSwap) {
//             ICurveV2Pool(exchange).exchange_underlying(curveV2Data.i, curveV2Data.j, fromAmount, 1);
//         }
//         else {
//             ICurveV2Pool(exchange).exchange(curveV2Data.i, curveV2Data.j, fromAmount, 1);
//         }

//         // if (address(toToken) == Utils.ethAddress()) {
//         //     uint256 receivedAmount = Utils.tokenBalance(WETH, address(this));
//         //     IWETH(WETH).withdraw(receivedAmount);
//         // }
//     }
// }


// // File contracts/CurveV2/Coin98CurveV2.sol

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// //import "@openzeppelin/contracts/access/Ownable.sol";
// //import "@openzeppelin/contracts/security/ReentrancyGuard.sol";



// abstract contract Coin98CurveV2 is CurveV2{
//     using SafeMath for uint256;

//     struct SwapParamCurveV2 {
//         //uint8 index;
//         IERC20 fromToken;
//         IERC20 toToken;
//         address targetExchange;
//         //uint percent;
//         bytes payload;
//         //uint256 networkFee;
//     }


//     function swapCurveV2(uint amount0Out, uint amount1Out,  bytes memory data) external  {
//         SwapParamCurveV2 memory swapParam = abi.decode(data, (SwapParamCurveV2));
//         //require(swapParam.index == 9, "Invalid Route");
//         //uint256 preBalance = swapParam.toToken.balanceOf(address(this));
//         swapOnCurveV2(
//                 swapParam.fromToken,
//                 swapParam.toToken,
//                 amount0Out,
//                 swapParam.targetExchange,
//                 swapParam.payload
//         );

//         //uint256 balance = swapParam.toToken.balanceOf(address(this));
//         //Utils.transferTokens(address(swapParam.toToken), to, balance - preBalance);

//         }

//     // function withdrawStuckERC20(address _token) external payable onlyOwner{
//     //     uint256 balanceERC20 = IERC20(_token).balanceOf(address(this));
//     //     uint256 balanceNativeToken  = address(this).balance;
//     //     if (balanceERC20 > 0) {
//     //         IERC20(_token).transfer(owner(), balanceERC20);
//     //     }
//     //     if (balanceNativeToken > 0) {
//     //         payable(owner()).transfer(balanceERC20);
//     //     }
//     // }
// }


// // File contracts/Uniswap/Coin98Uniswap(V2).sol

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// //import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// //import "@openzeppelin/contracts/access/Ownable.sol";

// interface pairSwap{
//     function token0() external returns(address);
// }


// abstract contract Coin98UniswapV2 {
//     uint256 private constant _UNISWAP_PAIR_SWAP_CALL_SELECTOR_32 =
//         0x022c0d9f00000000000000000000000000000000000000000000000000000000;

//     struct SwapParamUniV2 {
//         //uint8 index;
//         IERC20 fromToken;
//         IERC20 toToken;
//         address targetExchange;
//         //uint percent;
//         bytes payload;
//         //uint256 networkFee;
//     }

//     address public token0;
//     address public token1;

//     function poolSwap(
//         uint256 _amount,
//         address _pool,
//         bool _tokenInOut,
//         address _receiver
//     ) internal {
//         assembly {
//             let emptyPtr := mload(0x40)
//             mstore(0x40, add(emptyPtr, 0xc0))

//             function reRevert() {
//                 returndatacopy(0, 0, returndatasize())
//                 revert(0, returndatasize())
//             }
//             mstore(emptyPtr, _UNISWAP_PAIR_SWAP_CALL_SELECTOR_32)

//             switch iszero(_tokenInOut)
//             case 0 {
//                 mstore(add(emptyPtr, 0x04), 0)
//                 mstore(add(emptyPtr, 0x24), _amount) //B>A
//             }
//             default {
//                 mstore(add(emptyPtr, 0x04), _amount) //A>B
//                 mstore(add(emptyPtr, 0x24), 0)
//             }
//             mstore(add(emptyPtr, 0x44), _receiver)
//             mstore(add(emptyPtr, 0x64), 0x80)
//             mstore(add(emptyPtr, 0x84), 0)
//             if iszero(call(gas(), _pool, 0, emptyPtr, 0xa4, 0, 0)) {
//                 reRevert()
//             }
//         }
//     }


//     function swapUniV2(uint256 amount0Out, uint256 amount1Out, bytes memory data) external{

//         SwapParamUniV2 memory swapParam = abi.decode(data, (SwapParamUniV2));
//         //require(swapParam.index == 10, "Invalid Route");
//         TransferHelper.transferERC20(address(swapParam.fromToken),amount0Out,swapParam.targetExchange);
//         // TransferHelper.transferERC20(address(swapParam.fromToken), IERC20(swapParam.fromToken).balanceOf(address(this)),swapParam.targetExchange);
//         if (pairSwap(swapParam.targetExchange).token0() != address(swapParam.fromToken)) {
//             poolSwap(amount1Out, swapParam.targetExchange,false, address(this));
//         } else {
//             poolSwap(amount1Out, swapParam.targetExchange,true, address(this));
//         }
//     }

//     // function withdrawStuckERC20(address _token) external payable onlyOwner{
//     //     uint256 balanceERC20 = IERC20(_token).balanceOf(address(this));
//     //     uint256 balanceNativeToken  = address(this).balance;
//     //     if (balanceERC20 > 0) {
//     //         IERC20(_token).transfer(owner(), balanceERC20);
//     //     }
//     //     if (balanceNativeToken > 0) {
//     //         payable(owner()).transfer(balanceERC20);
//     //     }
//     // }
// }


// // File contracts/Delegate.sol

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;


// // import "@openzeppelin/contracts/access/Ownable.sol";

// contract Delegate  is Coin98UniswapV2,Coin98CurveV2 {
//     mapping(uint256 => bytes4) Adapter;

//     function addAdapter() external {
//         Adapter[0] = Coin98CurveV2.swapCurveV2.selector;
//         Adapter[1] = Coin98UniswapV2.swapUniV2.selector;
//     }
// }
