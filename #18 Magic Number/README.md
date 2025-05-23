
# Ethernaut Level #18: Magic Number – Solution

## 📜 Challenge Summary

Your task is to provide the `MagicNum` contract with a `Solver` contract that implements the function `whatIsTheMeaningOfLife()` and returns the number `42`.

### Constraints:

* The deployed contract **must be 10 bytes or less**.
* This means **you cannot use normal Solidity functions**, as they compile into larger bytecode.
* You need to deploy **raw EVM bytecode** via **inline assembly**.

---

## 🧠 Key Insight

In EVM, you can construct a contract entirely in **assembly** that returns `42` (0x2A in hex) using this minimal 10-byte runtime bytecode:

```evm
602A60005260206000F3
```

This EVM bytecode means:

| Opcode  | Description                              |
| ------- | ---------------------------------------- |
| `60 2A` | PUSH1 0x2A (push value 42)               |
| `60 00` | PUSH1 0x00 (destination memory offset)   |
| `52`    | MSTORE (store 42 at memory\[0])          |
| `60 20` | PUSH1 0x20 (length = 32 bytes)           |
| `60 00` | PUSH1 0x00 (memory offset)               |
| `F3`    | RETURN (return 32 bytes from memory\[0]) |

---

## 🛠️ Solidity Solution

We deploy this minimal bytecode using inline assembly in the constructor:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solver {
    constructor() {
        assembly {
            // Store runtime bytecode in memory
            mstore(0x80, 0x602A60005260206000F3)
            // Return it for deployment
            return(0x80, 0x0a)
        }
    }
}
```

This deploys a contract with exactly **10 bytes** of runtime code that, when called, returns `42`.

---

## ✅ How to Complete the Challenge

1. Deploy the `Solver` contract (above).
2. Call `setSolver(address(_solver))` on the `MagicNum` contract using the address of your deployed `Solver`.
3. Done! The level will recognize that your solver returns `42`.

---

## 🔐 Key Takeaway

> Sometimes, **using the Solidity compiler is too bloated**. Understanding raw **EVM opcodes** lets you create extremely compact and gas-efficient contracts—useful for edge-case optimizations and CTFs like Ethernaut.
