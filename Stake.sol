// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.8.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Stake {
    address public ownerContract;
    
    constructor(){
        ownerContract = msg.sender;
    }
    
    mapping(address => uint256) public stake;
    /**
     * @dev Store value in variable
     * @param invester value to store
     */
    function store(address invester, uint256 tokens)payable public {
        stake[invester] += tokens;
    }
}