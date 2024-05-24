// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./interfaces/ICaller.sol";

contract Oracle{
    mapping(address => bool) public whitelist;


    event DataRequested(uint256 indexed requestId, string inputData);
    event ResultProcessed(uint256 indexed requestId, uint8 result);
    
    constructor(address[] memory allowedAddresses) {
        for (uint256 i = 0; i < allowedAddresses.length; i++) {
            whitelist[allowedAddresses[i]] = true;
        }
    }
    
    modifier onlyWhitelisted() {
        require(whitelist[msg.sender], "Caller is not whitelisted");
        _;
    }
    
    function addToWhitelist(address _address) external {
        whitelist[_address] = true;
    }
    
    function removeFromWhitelist(address _address) external {
        whitelist[_address] = false;
    }
    
    function requestResult(uint256 requestId, string memory inputData) external onlyWhitelisted {
        emit DataRequested(requestId, inputData);
    }
    
    function sendResult(uint256 requestId, uint8 result) external returns (uint8) {
        ICaller(msg.sender).processResult(requestId, result);
        emit ResultProcessed(requestId, result);
    }
}
