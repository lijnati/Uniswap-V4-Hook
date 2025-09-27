// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IHooks} from "./interfaces/IHooks.sol";
import {PoolKey} from "./interfaces/PoolKey.sol";
import {BalanceDelta} from "./interfaces/BalanceDelta.sol";
import {IPoolManager} from "./interfaces/IPoolManager.sol";

abstract contract BaseHook is IHooks {
    error HookNotImplemented();

    function beforeInitialize(address, PoolKey calldata, uint160, bytes calldata)
        external
        virtual
        returns (bytes4)
    {
        revert HookNotImplemented();
    }

    function afterInitialize(address, PoolKey calldata, uint160, int24, bytes calldata)
        external
        virtual
        returns (bytes4)
    {
        revert HookNotImplemented();
    }

    function beforeSwap(address, PoolKey calldata, IPoolManager.SwapParams calldata, bytes calldata)
        external
        virtual
        returns (bytes4)
    {
        revert HookNotImplemented();
    }

    function afterSwap(address, PoolKey calldata, IPoolManager.SwapParams calldata, BalanceDelta, bytes calldata)
        external
        virtual
        returns (bytes4)
    {
        revert HookNotImplemented();
    }
}