// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IHooks} from "./IHooks.sol";

struct PoolKey {
    address currency0;
    address currency1;
    uint24 fee;
    int24 tickSpacing;
    IHooks hooks;
}