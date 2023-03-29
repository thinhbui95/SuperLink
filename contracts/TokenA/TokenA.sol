// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20{
    constructor() ERC20("tokenA", "A"){
        _mint(msg.sender, 1000000*10**18);

    }
    function mintToken(uint256 _amount) public {
        _mint(msg.sender,_amount);
    }

    
}