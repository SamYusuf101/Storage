//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library ConvertPrice {
    function version () public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface (0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData();
        return uint (price * 1e18);
    }

    function getConvertion (uint256 ethAmount) public view returns (uint256) {
       uint256 ethPrice = getPrice();
       uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
       return ethAmountInUsd;

    }

}