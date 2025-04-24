# 🛡️ Ethernaut Challenges – Solidity CTF Walkthroughs

This repository contains my solutions to [Ethernaut](https://ethernaut.openzeppelin.com/), a Web3/Solidity-based security wargame developed by OpenZeppelin. The game presents Capture the Flag (CTF) style challenges designed to teach and test your understanding of smart contract vulnerabilities and exploitation techniques.

## 🧠 Project Goals

The primary goal of this project is to **strengthen my Solidity and smart contract auditing skills** by completing all levels of Ethernaut. Each level mimics a real-world vulnerability and provides hands-on experience with attack surfaces such as:

- Reentrancy
- Delegatecall exploits
- Forceful ether transfers
- Predictable randomness
- Storage layout manipulation
- Gas griefing
- Token swaps and more

## 📁 Project Structure

Each folder corresponds to a specific Ethernaut challenge level and contains:

- A `.sol` file that implements the attack strategy (`Attack*.sol`, `Solver*.sol`, etc.)
- A `README.md` or comments that explain the vulnerability, the exploit strategy, and the Solidity concepts learned
- Level number and title are preserved in folder names for clarity (e.g., `#10 Reentrancy`, `#4 Telephone`)

```
.
├── #3 Coin Flip/
├── #4 Telephone/
├── #6 Delegation/
├── #7 Force/
├── #9 King/
├── #10 Reentrancy/
├── #11 Elevator/
├── #12 Privacy/
├── #18 Magic Number/
├── #21 Shop/
├── #23 Dex Two/
├── #27 Good Samaritan/
└── README.md
```

## 🧪 Example Challenges

| Level         | Focus Area              | Attack Type                  |
|---------------|--------------------------|-------------------------------|
| #10 Reentrancy | External calls in fallback functions | Drain contract balance using reentry |
| #4 Telephone  | `tx.origin` vs `msg.sender` | Spoof function call |
| #3 Coin Flip  | Predictable randomness | Exploit deterministic outcomes |
| #6 Delegation | `delegatecall` misuse   | Hijack contract ownership |
| #23 Dex Two   | Broken token validation | Manipulate swap price logic |

## 🛠️ Tech Stack

- Solidity (v0.6.x - v0.8.x)
- Hardhat or Remix for contract deployment/testing
- JavaScript or console-based interactions (via browser devtools or script)

## 🚀 Learning Outcomes

By completing this challenge series, I aim to:

- Gain deep intuition about Ethereum smart contract internals
- Understand common pitfalls in contract development
- Practice secure coding standards and mitigation techniques
- Build a strong foundation for future smart contract auditing work

## 📚 Credits

- [OpenZeppelin](https://openzeppelin.com) for creating and maintaining Ethernaut
- [Ethernaut Community](https://forum.openzeppelin.com/c/ethernaut/10) for shared insights and discussions
