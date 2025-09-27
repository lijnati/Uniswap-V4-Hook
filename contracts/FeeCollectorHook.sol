// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {BaseHook} from "./BaseHook.sol";
import {PoolKey} from "./interfaces/PoolKey.sol";
import {BalanceDelta, BalanceDeltaLibrary} from "./interfaces/BalanceDelta.sol";
import {IPoolManager} from "./interfaces/IPoolManager.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract FeeCollectorHook is BaseHook, Ownable {
    using BalanceDeltaLibrary for BalanceDelta;

    // Fee rate in basis points (100 = 1%)
    uint256 public feeRate = 10; // 0.1%
    
    // Collected fees per token
    mapping(address => uint256) public collectedFees;
    
    event FeeCollected(address indexed token, uint256 amount);
    event FeeRateUpdated(uint256 newRate);

    constructor() Ownable(msg.sender) {}

    function beforeSwap(
        address,
        PoolKey calldata key,
        IPoolManager.SwapParams calldata params,
        bytes calldata
    ) external override pure returns (bytes4) {
        // Log the swap attempt
        return this.beforeSwap.selector;
    }

    function afterSwap(
        address,
        PoolKey calldata key,
        IPoolManager.SwapParams calldata params,
        BalanceDelta delta,
        bytes calldata
    ) external override returns (bytes4) {
        // Calculate fee based on the swap amount
        int128 amount0 = delta.amount0();
        int128 amount1 = delta.amount1();
        
        if (amount0 > 0) {
            uint256 fee = uint256(uint128(amount0)) * feeRate / 10000;
            collectedFees[key.currency0] += fee;
            emit FeeCollected(key.currency0, fee);
        }
        
        if (amount1 > 0) {
            uint256 fee = uint256(uint128(amount1)) * feeRate / 10000;
            collectedFees[key.currency1] += fee;
            emit FeeCollected(key.currency1, fee);
        }
        
        return this.afterSwap.selector;
    }

    function setFeeRate(uint256 _feeRate) external onlyOwner {
        require(_feeRate <= 1000, "Fee rate too high"); // Maximum is = 10%
        feeRate = _feeRate;
        emit FeeRateUpdated(_feeRate);
    }

    function withdrawFees(address token, uint256 amount) external onlyOwner {
        require(collectedFees[token] >= amount, "Insufficient fees");
        collectedFees[token] -= amount;
    }
}