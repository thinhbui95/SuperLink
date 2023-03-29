// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PancakeStableSwapLP is ERC20 {
    address public immutable miner;

    constructor() ERC20("Pancake StableSwap LPs", "Stable-LP") {
        miner = msg.sender;
    }

    /**
     * @notice Checks if the msg.sender is the miner address.
     */
    modifier onlyMiner() {
        require(msg.sender == miner, "Not miner");
        _;
    }

    function mint(address _to, uint256 _amount) external onlyMiner {
        _mint(_to, _amount);
    }

    function burnFrom(address _to, uint256 _amount) external onlyMiner {
        _burn(_to, _amount);
    }
}