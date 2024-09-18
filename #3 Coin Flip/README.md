# Coin Flip

## Overview

This repository contains the solution for the **CoinFlip** challenge from Ethernaut. The challenge involves exploiting the deterministic nature of the `CoinFlip` contract to predict the outcome of coin flips. The goal is to win 10 consecutive flips by consistently predicting the result of each flip.

In this solution, the `CoinFlipHack` contract interacts with the vulnerable `CoinFlip` contract, predicting the outcome of each flip and calling the `flip` function with the correct guess.

## How the Exploit Works

The `CoinFlip` contract uses the block hash of the previous block to determine the result of a coin flip. This block hash is publicly accessible and deterministic, making it possible to predict the outcome of the coin flip.

The `AttackCoinFlip` contract replicates the logic of the vulnerable `CoinFlip` contract by using the block hash and dividing it by the same `FACTOR` constant. This allows it to predict the result of the coin flip every time and pass the correct guess to the `flip()` function.

Since the contract's randomness is based on predictable values (the block hash), this allows us to win consecutive coin flips and solve the challenge.

## Instructions to Use

1. **Deploy the Contract**:
   - Deploy the `AttackCoinFlip` contract on Sepolia and pass the address of the vulnerable `CoinFlip` contract to the constructor.

2. **Call the `flip()` Function**:
   - After deployment, call the `flip()` function on the `AttackCoinFlip` contract once per block. This will calculate the coin flip outcome and make the correct guess on the vulnerable contract.

3. **Repeat 10 Times**:
   - You need to call the `flip()` function 10 times, once per block, to win 10 consecutive coin flips. Once you achieve 10 wins, you can submit the challenge.
