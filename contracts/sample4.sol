// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";

contract EncryptedCounter4 {
    // Mapping from user address to their encrypted counter value
    mapping(address => euint8) private counters;

    constructor() {
        TFHE.setFHEVM(FHEVMConfig.defaultConfig());
    }

    function increment() public {
        // Initialize counter if it doesn't exist
        if (!TFHE.isInitialized(counters[msg.sender])) {
            counters[msg.sender] = TFHE.asEuint8(0);
        }

        // Perform encrypted addition to increment the sender's counter
        counters[msg.sender] = TFHE.add(counters[msg.sender], TFHE.asEuint8(1));
        TFHE.allowThis(counters[msg.sender]);
        TFHE.allow(counters[msg.sender], msg.sender);
    }

    function incrementBy(einput amount, bytes calldata inputProof) public {
        // Initialize counter if it doesn't exist
        if (!TFHE.isInitialized(counters[msg.sender])) {
            counters[msg.sender] = TFHE.asEuint8(0);
        }

        // Convert input to euint8 and add to sender's counter
        euint8 incrementAmount = TFHE.asEuint8(amount, inputProof);
        counters[msg.sender] = TFHE.add(counters[msg.sender], incrementAmount);
        TFHE.allowThis(counters[msg.sender]);
        TFHE.allow(counters[msg.sender], msg.sender);
    }

    function getCounter() public view returns (euint8) {
        // Return the encrypted counter value for the sender
        return counters[msg.sender];
    }
}
