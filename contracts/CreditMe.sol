// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CreditMe {

  uint256 public minimumUsd = 50;
  address[] public funders;
  mapping (address => uint256) public amountToNumber;

  function FundMe() public payable {
    require(getConvertion(msg.value) >= minimumUsd, "Not Enough");
    funders.push(msg.sender);
    //mappin sender to value sent
    amountToNumber[msg.sender] = msg.value;

  }

  function getPrice () public view returns(uint256){
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 price,,,) = priceFeed.latestRoundData();
    // convert eth in terms of usd
    return uint256(price * 10e18);

  }

  function getVersion () public view returns(uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    return priceFeed.version();

  }

  function getConvertion(uint256 ethAmount) public view returns(uint256) {
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUsd;
  }
}