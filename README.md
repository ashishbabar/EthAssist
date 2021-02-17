<p align="center">
  <img width="200" height="200" src="https://raw.githubusercontent.com/ashishbabar/EthAssist/main/logo_200x200.png">
</p>

This is an implementation of Contracts for accepting Investment through Ethers. Investers will receive ERC20 based token EAS

  - 1 Ether = 1000 EthAssist token
  - More than 1 and less than 5 Ether investment will have 10% bonus tokens.
  - More thann 5 Ether investment will have 20% bonus tokens.
  - 90% of the investment (ether) should be locked in a reserve contract along with 100% tokens he/she is going to get(Ideally it should be locked 365 days but for now I've set it to 15 Minutes)
  - 10% of the investment should go to a liquidity contract.

At the end of 15 minutes investor can take following functions (Any of the action)
  - Cancel investment - in this case 90% of investment will return to investors from reserve contract 100% tokens will be burned automatically.
  - Stake Investment - Stake the investment. 90% of the funds will go to liquidity contract and 100% EthAssist tokens goes to Staking Contract.

