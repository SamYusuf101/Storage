// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;
import "./PriceConverter.sol";

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract CreditMe {

  using PriceConverter for uint256;
  uint256 public minimumUsd = 50;
  address[] public funders;
  mapping (address => uint256) public amountToNumber;

  function FundMe() public payable {
    require(msg.value.getConvertion() >= minimumUsd, "Not Enough");
    funders.push(msg.sender);
    //mapping sender to value sent
    amountToNumber[msg.sender] += msg.value;

  }

 function withdraw()public {
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
  (bool Sendsuccess,) =payable(msg.sender).call{value: address(this).balance}("");
  require(Sendsuccess, "failed");

 }
 }

  
