# Ethernaut Level #11: Elevator - Solution

## Challenge Overview

The objective of this level is to exploit the `Elevator` contract and convince it that you've reached the top floor, even though the contract tries to verify the floor using an external `Building` contract.

## Vulnerability

The `Elevator` contract relies on an external call to `isLastFloor(uint)` in a user-supplied contract (via `Building` interface) to determine if the elevator has reached the top. However, it trusts this return value without validating its consistency. Since this function is called **twice**, a malicious contract can return **different values on each call**.

## Solution Strategy

1. Implement a malicious contract that returns:

   * `false` on the first call (to enter the `if` condition)
   * `true` on the second call (to pass the internal check)
2. Call `goTo(_floor)` from your attacker contract to trick the `Elevator` into setting `top = true`.

## How to Use

1. Deploy `AttackElevator` with the target Elevator instance address.
2. Call `attack(<desired floor>)` to trigger the exploit.
3. The `Elevator` contract will be tricked into believing it reached the top.

## Key Takeaway

**Never trust external calls to untrusted contracts for critical logic without consistency checks.** This is an example of an **inconsistent external dependency** vulnerability.
