// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;
import "./PriceConverter.sol";

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error notOwner();


contract CreditMe {

  using PriceConverter for uint256;
  address public immutable i_owner;
  uint256 public constant MINIMUM_USD = 50 * 1e18;
  address[] public  funders;
  mapping (address => uint256) public amountToNumber;

 constructor() {
  i_owner = msg.sender;
 }

  function FundMe() public payable {
    require(msg.value.getConvertion() >= MINIMUM_USD, "Not Enough");
    funders.push(msg.sender);
    //mapping sender to value sent
    amountToNumber[msg.sender] += msg.value;

  }

 function withdraw()public onlyOwner{

  for(uint256 funderIndex; funderIndex<funders.length; funderIndex++){
    address funder = funders[funderIndex];
    amountToNumber[funder] = 0;
  }

  funders = new address[](0);
  //transfer
  payable(msg.sender).transfer(address(this).balance);
  //send
  bool success = payable(msg.sender).send(address(this).balance);
  require(success, "failed");
  //call
  (bool Sendsuccess,) = payable(msg.sender).call{value: address(this).balance}("");
  require(Sendsuccess, "failed");

 }
modifier onlyOwner {
  if(msg.sender != i_owner) {revert notOwner();}
  _;

 }
}  
