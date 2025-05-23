# Ethernaut Level #12: Privacy – Solution

## 📜 Challenge Overview

The goal of this level is to **unlock the contract** by passing the correct key to the `unlock(bytes16 _key)` function.

Despite being marked `private`, the key can still be accessed by understanding **how Ethereum stores contract data in storage**.

## 🔓 Vulnerability

The `Privacy` contract uses:

```solidity
bytes32[3] private data;
```

and then checks in `unlock`:

```solidity
require(_key == bytes16(data[2]));
```

While `data` is marked `private`, **all contract storage is publicly readable on-chain**. Using tools like `web3.eth.getStorageAt`, we can extract the contents of `data[2]` directly from storage.

## 🧠 Key Insight: Solidity Storage Layout

Solidity stores variables in 32-byte (256-bit) storage slots sequentially:

| Slot | Variable                                                         |
| ---- | ---------------------------------------------------------------- |
| 0    | `locked` (1 byte)                                                |
| 1    | `ID` (32 bytes)                                                  |
| 2    | `flattening`, `denomination`, `awkwardness` (packed into 1 slot) |
| 3    | `data[0]`                                                        |
| 4    | `data[1]`                                                        |
| 5    | `data[2]` ← 🔑 target                                            |

## 🛠️ Steps to Solve

1. Use the contract address to access storage slot `5`:

```js
await web3.eth.getStorageAt(contract.address, 5)
// Example output: '0x1a2b3c...'
```

2. Take the first 16 bytes (i.e., 32 characters after `0x`) of this value:

```js
// Example
const key = '0x1a2b3c...'; // Trimmed to 16 bytes
```

3. Call `unlock(key)` in Remix or a script.

4. Check that `locked == false`:

```js
await contract.locked() // should return false
```

✅ Level passed!

## 🔐 Key Takeaway

> **Private ≠ Secret** in Solidity.
> All storage data on Ethereum is public—**marking a variable `private` only restricts access through Solidity code**, not from reading it via RPC or EVM inspection.
