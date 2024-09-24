// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solver {
    constructor() {
        assembly {
            // Store the runtime bytecode in memory
            mstore(0x80, 0x602A60005260206000F3)
            // Return the runtime bytecode for deployment
            return(0x80, 0x0a)
        }
    }
}
