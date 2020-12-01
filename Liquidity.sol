// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.8.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Liquidity {
    address public ownerContract;
    
    constructor(){
        ownerContract = msg.sender;
    }
    
    mapping(address => uint256) public investers;
    /**
     * @dev Store value in variable
     * @param invester value to store
     */
    function store(address invester)payable public {
        require(ownerContract == msg.sender, "EthAssist : Not allowed");
        investers[invester] += msg.value;
    }
    
     /**
     * @dev Returns balance from contract
     */
    function getContractEthers() view public returns(uint){
        return address(this).balance;
    }
}