// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./BasicStorage.sol";

contract Storagebag {

  BasicStorage[] public basicStorageArray;

  function CreateAddress ()public {
    BasicStorage basicStorage = new BasicStorage();
    basicStorageArray.push(basicStorage);
  }

  function sfStore(uint256 _basicStorageIndex, uint256 _basicStorageNumber) public  {
    basicStorageArray[_basicStorageIndex].store(_basicStorageNumber);

  }
  

function sfGet (uint256 _basicStorageIndex) public view returns(uint256) {
  return basicStorageArray[_basicStorageIndex].retrieve();

}

}