// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PoolKey} from "./PoolKey.sol";
import {BalanceDelta} from "./BalanceDelta.sol";
import {IPoolManager} from "./IPoolManager.sol";

interface IHooks {
    function beforeInitialize(address sender, PoolKey calldata key, uint160 sqrtPriceX96, bytes calldata hookData)
        external
        returns (bytes4);

    function afterInitialize(address sender, PoolKey calldata key, uint160 sqrtPriceX96, int24 tick, bytes calldata hookData)
        external
        returns (bytes4);

    function beforeSwap(address sender, PoolKey calldata key, IPoolManager.SwapParams calldata params, bytes calldata hookData)
        external
        returns (bytes4);

    function afterSwap(address sender, PoolKey calldata key, IPoolManager.SwapParams calldata params, BalanceDelta delta, bytes calldata hookData)
        external
        returns (bytes4);
}