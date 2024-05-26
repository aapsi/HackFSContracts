// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./interfaces/IOracle.sol";

contract Caller {

    uint256 public requestID;
    IOracle oracle;
    string public url = "";

    mapping(uint256 => uint8) public results;

    event ResultProcessed(uint256 indexed requestId, uint8 result);
    event DataRequested(uint256 indexed requestId, string inputData);

    constructor(address OracleAddress) {
        requestID = 0;
        oracle = IOracle(OracleAddress);
    }

    function requestResult(bytes32 transactionData) public returns (uint256) {
        requestID += 1;
        oracle.requestResult(requestID, transactionData, url);
    }

    function processResult(uint256 _requestID, uint8 result) public returns (uint8) {
        results[_requestID] = result;
        emit ResultProcessed(_requestID, result);
    }

    // tx -> logs -> 
}
