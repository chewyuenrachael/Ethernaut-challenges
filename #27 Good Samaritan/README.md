# Ethernaut Level #27: Good Samaritan

## Overview

Challenge: exploit the `GoodSamaritan` contract and drain all of its coins. The `GoodSamaritan` contract donates 10 coins at a time to external contracts, but it sends the remainder if it detects insufficient balance.

By taking advantage of how errors are handled, we can force the contract to send all remaining coins by triggering an exception during the donation process.

## Vulnerability

The main vulnerability lies in the way the `GoodSamaritan` contract handles exceptions. When the `donate10` function fails due to insufficient balance (by reverting with a specific error), it sends all remaining tokens. We can exploit this behavior by forcing a revert when exactly 10 coins are transferred.

## Approach

1. Implement an `Attack` contract that interacts with the `GoodSamaritan` contract.
2. Call the `requestDonation()` function from the `GoodSamaritan` contract to initiate the donation process.
3. Inside the `notify()` function, trigger a custom error (`NotEnoughBalance`) when exactly 10 coins are transferred, which will cause the contract to revert and send all remaining tokens.

## Steps

1. **Deploy the Attack contract** and pass the `GoodSamaritan` contract address to the `pwn` function.
2. The `GoodSamaritan` contract will attempt to transfer 10 coins to the `notify()` function.
3. When 10 coins are transferred, the `notify()` function will revert the transaction with the custom error `NotEnoughBalance`, triggering the remainder of the donation process.
4. The contract will send all remaining tokens to complete the challenge.

## Conclusion

By exploiting the way the `GoodSamaritan` contract handles errors during the donation process, we can trigger a transfer of the entire balance in one transaction.
