# Deployment Guide

This document provides instructions for deploying the NFT Staking Protocol to ZKSync Era testnet.

## Why ZKSync Era?

We chose ZKSync Era Sepolia testnet for deployment because:

1. **Low Transaction Costs**: ZKSync Era's rollup architecture significantly reduces gas costs
2. **EVM Compatibility**: Full compatibility with Solidity contracts
3. **Fast Finality**: Quick transaction confirmation times
4. **Active Ecosystem**: Growing DeFi and NFT ecosystem
5. **Easy Verification**: Built-in contract verification support

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
- A wallet with ZKSync Era Sepolia testnet ETH
- [Get testnet ETH from faucet](https://portal.zksync.io/faucet)

## Environment Setup

Create a `.env` file in the project root:

```bash
# Required
PRIVATE_KEY=your_private_key_here

# Optional (defaults to deployer address)
TREASURY_ADDRESS=0x...

# For demo transactions (set after initial deployment)
STAKING_ADDRESS=0x...
MOCK_NFT_ADDRESS=0x...
REWARD_TOKEN_ADDRESS=0x...
```

Load environment variables:

```bash
source .env
```

## Deployment Steps

### 1. Deploy All Contracts

```bash
forge script script/Deploy.s.sol:Deploy \
  --rpc-url https://sepolia.era.zksync.dev \
  --broadcast \
  --verify \
  --verifier zksync \
  --verifier-url https://explorer.sepolia.era.zksync.dev/contract_verification
```

**Expected Output:**

```
Deployer: 0x...
Treasury: 0x...
StakeRewardToken deployed at: 0x...
NFTStaking deployed at: 0x...
MockNFT deployed at: 0x...
```

### 2. Save Contract Addresses

After deployment, update your `.env`:

```bash
STAKING_ADDRESS=<deployed-staking-address>
MOCK_NFT_ADDRESS=<deployed-mock-nft-address>
REWARD_TOKEN_ADDRESS=<deployed-reward-token-address>
```

### 3. Run Demo Transactions

This script demonstrates all protocol features:

```bash
source .env

forge script script/Deploy.s.sol:DemoTransactions \
  --rpc-url https://sepolia.era.zksync.dev \
  --broadcast
```

**Demonstrates:**

- Staking NFTs
- Checking pending rewards
- Claiming rewards
- Instant unstaking with penalty
- Treasury receiving penalty fees

### 4. Unstake After Lock Period (Optional)

Wait 7 days, then run:

```bash
export TOKEN_ID=<your-staked-token-id>

forge script script/Deploy.s.sol:UnstakeAfterLock \
  --rpc-url https://sepolia.era.zksync.dev \
  --broadcast
```

## Deployed Contract Addresses

> **Note**: Fill in these addresses after your deployment

| Contract         | Address | Verified             |
| ---------------- | ------- | -------------------- |
| StakeRewardToken | `0x...` | [View on Explorer]() |
| NFTStaking       | `0x...` | [View on Explorer]() |
| MockNFT          | `0x...` | [View on Explorer]() |

## Transaction Links

> **Note**: Fill in these links after running demo transactions

| Action                         | Transaction Hash |
| ------------------------------ | ---------------- |
| Deploy StakeRewardToken        | [0x...]()        |
| Deploy NFTStaking              | [0x...]()        |
| Deploy MockNFT                 | [0x...]()        |
| Stake NFT #1                   | [0x...]()        |
| Stake NFT #2                   | [0x...]()        |
| Claim Rewards                  | [0x...]()        |
| Instant Unstake (with penalty) | [0x...]()        |
| Normal Unstake (after lock)    | [0x...]()        |

## Verification

Contracts can be verified on the ZKSync Era Sepolia explorer:

**Manual Verification:**

1. Go to [ZKSync Era Sepolia Explorer](https://sepolia.era.zksync.dev/)
2. Find your contract address
3. Click "Verify Contract"
4. Select "Solidity (Standard JSON Input)"
5. Upload the JSON from `out/` directory

**Automatic Verification (with forge):**

```bash
forge verify-contract <CONTRACT_ADDRESS> src/NFTStaking.sol:NFTStaking \
  --verifier zksync \
  --verifier-url https://explorer.sepolia.era.zksync.dev/contract_verification \
  --rpc-url https://sepolia.era.zksync.dev
```

## Network Configuration

| Parameter    | Value                           |
| ------------ | ------------------------------- |
| Network Name | ZKSync Era Sepolia              |
| RPC URL      | https://sepolia.era.zksync.dev  |
| Chain ID     | 300                             |
| Currency     | ETH                             |
| Explorer     | https://sepolia.era.zksync.dev/ |

## Troubleshooting

### "Insufficient funds"

Get testnet ETH from the [ZKSync Faucet](https://portal.zksync.io/faucet)

### "Contract not verified"

Try manual verification through the block explorer UI

### "Transaction failed"

- Check gas limit
- Ensure you have enough ETH
- Verify contract addresses are correct

### "Lock period not ended"

For normal unstake, wait the full 7-day lock period or use `instantUnstake()` with penalty

## Post-Deployment Checklist

- [ ] All contracts deployed successfully
- [ ] Contracts verified on block explorer
- [ ] MINTER_ROLE granted to staking contract
- [ ] MockNFT collection whitelisted
- [ ] Demo transactions completed
- [ ] Treasury receiving penalty fees confirmed

## Issues Encountered

> Document any issues you encountered during deployment here

1. **Issue**: (Description)
   **Solution**: (How you resolved it)

## Additional Notes

- The default reward rate is 1 token per second per NFT (1e18 wei)
- The default lock period is 7 days (604800 seconds)
- The default max penalty is 50% (5000 basis points)
- Treasury address receives all penalty fees as minted tokens
