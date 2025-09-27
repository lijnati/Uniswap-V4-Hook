# Uniswap V4 Hook Development

This project demonstrates how to build a custom Uniswap V4 hook using Hardhat.

## Project Structure

```
├── contracts/
│   ├── interfaces/          # Core V4 interfaces
│   ├── BaseHook.sol        # Abstract base hook contract
│   └── FeeCollectorHook.sol # Example hook implementation
├── test/                   # Test files
├── scripts/               # Deployment scripts
└── hardhat.config.js     # Hardhat configuration
```

## Hook Example: FeeCollectorHook

The `FeeCollectorHook` demonstrates a practical V4 hook that:
- Collects a small fee (0.1% by default) on each swap
- Allows the owner to adjust fee rates
- Tracks collected fees per token
- Emits events for fee collection

## Key Hook Functions

### beforeSwap
Called before a swap is executed. Use this to:
- Validate swap parameters
- Apply pre-swap logic
- Modify swap behavior

### afterSwap
Called after a swap is completed. Use this to:
- Collect fees
- Update state based on swap results
- Emit events

## Setup

1. Install dependencies:
```bash
npm install
```

2. Compile contracts:
```bash
npm run compile
```

3. Run tests:
```bash
npm run test
```

4. Deploy to local network:
```bash
npx hardhat node
npm run deploy
```

<!-- ## Hook Development Tips

1. **Hook Address Requirements**: V4 hooks must be deployed to specific addresses based on their permissions
2. **Gas Optimization**: Keep hook logic minimal to avoid high gas costs
3. **Security**: Always validate inputs and handle edge cases
4. **Testing**: Thoroughly test all hook functions with various scenarios -->
