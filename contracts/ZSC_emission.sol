pragma solidity ^0.4.18;

import 'node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'node_modules/zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';
import 'contracts/ZSC_emission_parts.sol';

contract ZSC_emission is Ownable, StandardToken, ZSC_emission_parts {
  
  string public name = "ZSCoin";
  string public symbol = "ZSC";
  uint8 public decimals = 18;
  
  uint256 businessAdvisorsPart;
  uint256 bountyProgrammPart;
  uint256 mainTeamPart;
  uint256 reserveFundPart;
  uint256 tokenSalesPart;
  
  bool    freezing = true;
  
  function ZSC_emission() public {
    
    uint256 ZSC_TOTAL_EMISSION = 100000000 * (10 ** uint256(decimals));
    
    totalSupply_ = ZSC_TOTAL_EMISSION;
    
    businessAdvisorsPart = (ZSC_TOTAL_EMISSION / 100) *  2; // %
    bountyProgrammPart   = (ZSC_TOTAL_EMISSION / 100) *  3; // %
    mainTeamPart         = (ZSC_TOTAL_EMISSION / 100) * 10; // %
    reserveFundPart      = (ZSC_TOTAL_EMISSION / 100) * 20; // %
    tokenSalesPart       = (ZSC_TOTAL_EMISSION / 100) * 65; // %
    
    balances[businessAdvisorsPartAddress] = businessAdvisorsPart;
    balances[bountyProgrammPartAddress]   = bountyProgrammPart; 
    balances[mainTeamPartAddress]         = mainTeamPart; 
    balances[reserveFundPartAddress]      = reserveFundPart;
    balances[tokenSalesPartAddress]       = tokenSalesPart;
    
    //Transfer(0x0, businessAdvisorsPartAddress, businessAdvisorsPart);
    //Transfer(0x0, bountyProgrammPartAddress,   bountyProgrammPart);
    //Transfer(0x0, mainTeamPartAddress,         mainTeamPart);
    //Transfer(0x0, reserveFundPartAddress,      reserveFundPart);
    //Transfer(0x0, tokenSalesPartAddress,       tokenSalesPart);
  }
  
  modifier whenNotTransferFreezing(){
    require(freezing == false);
    _;
  }
  
  function crowdsaleEnd() public onlyOwner returns (uint8) {
    freezing = false;
    return 52;
  }
  
  function isUnfreezed() public returns (bool) {
    return !freezing;
  }
  
  function transferFromBusinessAdvisorsPartAddress(address _to, uint256 _value) public returns (bool) {
    require(msg.sender == businessAdvisorsPartAddress);
    return super.transfer(_to, _value);
  }
  
  function transferFromBountyProgrammPartAddress(address _to, uint256 _value) public returns (bool) {
    require(msg.sender == bountyProgrammPartAddress);
    return super.transfer(_to, _value);
  }
  
  function transferFromMainTeamPartAddress(address _to, uint256 _value) public returns (bool) {
    require(msg.sender == mainTeamPartAddress);
    return super.transfer(_to, _value);
  }
  
  function transferFromReserveFundPartAddress(address _to, uint256 _value) public returns (bool) {
    require(msg.sender == reserveFundPartAddress);
    return super.transfer(_to, _value);
  }
  
  function transferFromTokenSalesPartAddress(address _to, uint256 _value) public returns (bool) {
    require(msg.sender == tokenSalesPartAddress);
    return super.transfer(_to, _value);
  }
  
  function transfer(address _to, uint256 _value) public whenNotTransferFreezing returns (bool) {
    return super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint256 _value) public whenNotTransferFreezing returns (bool) {
    return super.transferFrom(_from, _to, _value);
  }

  function approve(address _spender, uint256 _value) public whenNotTransferFreezing returns (bool) {
    return super.approve(_spender, _value);
  }
  
}