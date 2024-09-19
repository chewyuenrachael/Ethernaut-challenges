### README: Reentrancy

---

#### 1. **Summary of the Solution**

The **Reentrancy** challenge exposes a vulnerability where the `withdraw()` function of a contract sends Ether to a caller before updating their balance, creating an opening for a reentrancy attack. In this challenge, I developed a custom smart contract (ReentrancyAttack.sol) that exploits this vulnerability by re-entering the `withdraw()` function multiple times before the balance is updated, allowing me to drain all the funds from the vulnerable contract.

The key insight in this solution is to exploit the fact that the vulnerable contract first transfers Ether via a low-level `call` function and only updates the caller's balance after the Ether is sent. My attack contract leverages this by recursively calling `withdraw()` in its `receive()` function, continuing to withdraw funds until the contract's balance is drained.

Steps of the attack:
1. Deploy the attack contract.
2. Call `donate()` to establish a balance with the vulnerable contract.
3. Trigger the re-entrancy attack through the `withdraw()` function.
4. The contract continues to withdraw recursively until all funds are depleted.
5. Collect the drained funds by calling `collectEther()`.

---

#### 2. **Preventing the Reentrancy Attack**

To prevent this type of reentrancy attack, the contract should implement the **Checks-Effects-Interactions** pattern. This pattern ensures that all internal state changes (like updating balances) are made **before** any external interactions, such as transferring Ether. 

In the context of this challenge, a secure version of the `withdraw()` function would first update the caller's balance, then send the Ether, preventing any recursive withdrawals.

Here’s what the code would look like with reentrancy protection:

```solidity
function withdraw(uint256 _amount) public {
    // Step 1: Ensure the caller has enough balance to withdraw
    if (balances[msg.sender] >= _amount) {
        // Step 2: Update the balance first, before sending Ether
        balances[msg.sender] -= _amount;  

        // Step 3: Transfer Ether to the caller after the balance is updated
        (bool result, ) = msg.sender.call{value: _amount}("");  
        
        // Step 4: Ensure the transfer was successful
        require(result, "Transfer failed");
    }
}
```

**Explanation**:
1. **Update the Balance First**: 
   - The balance is deducted before the transfer happens. This way, if the caller tries to re-enter the contract through a fallback function (using `receive()`), the balance has already been reduced, preventing further withdrawals.
   
2. **Send Ether After**: 
   - After the internal state (balance) has been updated, the contract sends Ether to the caller using the low-level `call` function. This follows the principle of keeping interactions with external addresses last in the function to avoid reentrancy.

3. **Checks-Effects-Interactions Pattern**:
   - This is a recommended best practice in Solidity to avoid external contract calls while the internal state is still vulnerable. By separating the internal logic (balance updates) from external calls (Ether transfers), we can avoid many potential attack vectors, including reentrancy.
