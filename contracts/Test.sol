// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./ConvertPrice.sol";

error ownerTest();

contract funds {
    address public owner;
    mapping (address => uint256) public addressToAmount;
    uint256 public minimumUsd;
    address[] public fund;

    function fundMe () public payable {
        require (msg.value > minimumUsd);
        fund.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;

    }

    function withdraw () public {
        for (uint256 fundIndex; fundIndex < fund.length; fundIndex++) {
          address funding   = fund[fundIndex];
          addressToAmount[funding] = 0;
   

        } 
               fund = new address[](0);

        // transfer
        payable(msg.sender).transfer(address(this).balance);

        // send

        bool success =payable(msg.sender).send(address(this).balance);
        require(success, "not succesful");

        (bool sendSuccess,) = payable (msg.sender).call{value:address(this).balance}("");
        require(sendSuccess, "not sent");


        
    }

    modifier ownertest{
        if(msg.sender != owner) {revert owner();}
        _;
    }

    
    
}