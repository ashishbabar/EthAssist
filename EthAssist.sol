
pragma solidity >=0.4.6 <0.8.0;

import "./Reserve.sol"; 
import "./Liquidity.sol";
import "./Stake.sol";
import "./ERC20.sol";
/**
 * @title ethAssist
 * @dev Store & retrieve investments in reserve and liquidity contracts
 */
contract ethAssist{

    uint256 number;
    Reserve reserveContract;
    Liquidity liquidityContract;
    Stake stakeContract;
    ERC20 ethAssist;
    address ownerAddress;
    
    /** 
     * @dev Create a new contract for pay 
     * @param name of ERC 20 contract 
     * @param symbol of ERC 20 contract 
     */
    constructor(string memory name, string memory symbol) {
        ownerAddress = msg.sender;
        reserveContract = new Reserve();
        liquidityContract = new Liquidity();
        stakeContract = new Stake();
        ethAssist = new ERC20(name, symbol);
    }
    
    
    /**
     * @dev Invest  value in variable
     */
    function deposit() payable public{
        uint256 tokens = getTokensForEthers(msg.value);
        uint256 ethersTobeLocked = (msg.value * 90)/100;
        uint256 ethersTobeLiquidated = msg.value - ethersTobeLocked;
        reserveContract.store{value:ethersTobeLocked}(msg.sender, tokens);
        liquidityContract.store{value:ethersTobeLiquidated}(msg.sender);
    }

    /**
     * @dev Calculates tokens for ethers
     * @param weis value to store
     */
    function getTokensForEthers(uint256 weis) private pure returns (uint256) {
        uint256  weiInEthers = weis / 1000000000000000000;
        uint256 tokenAllowance = 1000;
        tokenAllowance = weiInEthers * tokenAllowance;
        if(weiInEthers > 1 && weiInEthers <= 5){
            tokenAllowance += (tokenAllowance * 10)/100;
        }else if( weiInEthers > 5){
            tokenAllowance += (tokenAllowance * 20)/100;
        }else{
            
        }
        return tokenAllowance;
    }
    

    /**
     * @dev credits investment and burns tokens
     */
    function cancelInvestment() public {
        // uint256 investmentTimestamp = reserveContract.retrieveTime(msg.sender);
        // require(block.timestamp > (investmentTimestamp + (1 * 60)), "Pay : Lock duration error!");
        reserveContract.cancel(msg.sender);
    }
    
    
      /**
     * @dev Liquidates reserved investment and stakes reserved tokens
     */
    function stakeInvestment() payable public returns (uint256 liquidityAmount, uint256 stakeTokens){
        // uint256 investmentTimestamp = reserveContract.retrieveTime(msg.sender);
        // require(block.timestamp > (investmentTimestamp + (1 * 60)), "Pay : Lock duration error!");

        (liquidityAmount, stakeTokens) = reserveContract.stake(msg.sender,liquidityContract);
        require(liquidityAmount > 0, "EthAssist : Reserve amount zero");
        require(stakeTokens > 0, "EthAssist : Token amount zero");
        // Update liquidityContract and stakeContract
        // stakeContract.store(msg.sender, stakeTokens);
        ethAssist.transfer(msg.sender,stakeTokens);
    }
    
    
    /**
     * @dev Return value 
     * @return value of 'Reserve'
     */
    function retrieveReserverContract() public view returns (Reserve){
        require(msg.sender == ownerAddress);
        return reserveContract;
    }
    
    /**
     * @dev Return value 
     * @return value of 'Liquidity'
     */
    function retrieveLiquidityContract() public view returns (Liquidity){
        require(msg.sender == ownerAddress);
        return liquidityContract;
    }
    
    /**
     * @dev Return value 
     * @return value of 'Stake'
     */
    function retrieveStakeContract() public view returns (Stake){
        require(msg.sender == ownerAddress);
        return stakeContract;
    }
    
    /**
     * @dev Return value 
     * @return value of 'Pay token'
     */
    function retrieveERC20Contract() public view returns (ERC20){
        require(msg.sender == ownerAddress);
        return ethAssist;
    }
    
    /**
     * @dev Returns balance from contract
     */
    function getContractEthers() view public returns(uint){
        return address(this).balance;
    }
    
}