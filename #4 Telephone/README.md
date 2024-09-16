# Overview

The vulnerability lies in the improper use of tx.origin and msg.sender in the changeOwner() function. This solution demonstrates how to bypass the ownership check by leveraging a contract-to-contract call.

## Challenge Description

The `Telephone` contract has an ownership-changing function that contains a check intended to prevent direct user calls from changing the owner. The key piece of logic is the use of `tx.origin` in this check:

```solidity
function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
        owner = _owner;
    }
}
```

- **`tx.origin`** refers to the address that originally initiated the transaction.
- **`msg.sender`** refers to the address of the immediate caller.

The contract allows changing ownership if and only if `tx.origin` is **not equal** to `msg.sender`. This check can be bypassed by using an intermediary contract to make the call, which will satisfy the condition `tx.origin != msg.sender`.

## Solution Rationale

The vulnerability exists because the contract assumes that a user can only call `changeOwner()` directly. However, in Solidity, contracts can call other contracts, and when a contract calls another contract, `msg.sender` will be the calling contract's address, while `tx.origin` will still be the original user's external address.

This means we can create an **intermediary contract** that calls the `changeOwner()` function. In this case:
- **`tx.origin`** will remain the user’s address.
- **`msg.sender`** will be the intermediary contract’s address.

This satisfies the condition `tx.origin != msg.sender`, allowing us to change ownership.

## Steps to Execute the Attack

1. **Deploy the Attack Contract**:
   Deploy the `AttackTelephone` contract, passing the address of the `Telephone` contract as a parameter to the constructor.

   Example:
   ```solidity
   AttackTelephone attackContract = new AttackTelephone(<Telephone contract address>);
   ```

2. **Execute the Attack**:
   Call the `attack()` function on the deployed `AttackTelephone` contract, passing in the address you want to become the new owner (e.g., your own address).

   Example:
   ```solidity
   attackContract.attack(<your address>);
   ```

3. **Verify Ownership Change**:
   After executing the attack, the ownership of the `Telephone` contract should have been transferred to the address provided in the `attack()` function.

## Why the Solution Works

The vulnerability in the `Telephone` contract arises from the use of `tx.origin`, which should generally be avoided in access control checks. By introducing an intermediary contract, the conditions in the `changeOwner()` function can be manipulated. 

- **`tx.origin`** remains the user’s address throughout the call chain.
- **`msg.sender`** in the `Telephone` contract becomes the intermediary contract's address, satisfying the `tx.origin != msg.sender` condition.

This allows us to bypass the check and successfully change the ownership of the contract.

## Conclusion

This solution highlights the importance of using `msg.sender` for access control checks and avoiding the use of `tx.origin` in critical logic. By exploiting the improper use of `tx.origin`, we were able to change the ownership of the `Telephone` contract by making a contract-to-contract call.
