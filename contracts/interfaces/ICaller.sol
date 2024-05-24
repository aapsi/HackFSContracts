// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface ICaller {
    event ResultProcessed(uint256 indexed requestId, uint8 result);

    function processResult(uint256 _requestID, uint8 result) external view returns (uint8);
}