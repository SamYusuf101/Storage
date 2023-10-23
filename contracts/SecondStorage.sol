pragma solidity ^0.8.0;

import "./BasicStorage.sol";


contract SecondStorage is BasicStorage{
    function store(uint256 _bestNumber) public override{
         bestNumber = _bestNumber + 5;
    }
    
}