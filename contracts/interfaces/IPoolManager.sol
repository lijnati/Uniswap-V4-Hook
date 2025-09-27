// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PoolKey} from "./PoolKey.sol";
import {BalanceDelta} from "./BalanceDelta.sol";

interface IPoolManager {
    function swap(PoolKey memory key, IPoolManager.SwapParams memory params, bytes calldata hookData)
        external
        returns (BalanceDelta);
    
    struct SwapParams {
        bool zeroForOne;
        int256 amountSpecified;
        uint160 sqrtPriceLimitX96;
    }
}