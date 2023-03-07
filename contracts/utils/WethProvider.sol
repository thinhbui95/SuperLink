pragma solidity ^0.8.0;


abstract contract WethProvider {
    address public immutable WETH;

    constructor(address weth)  {
        WETH = weth;
    }
}