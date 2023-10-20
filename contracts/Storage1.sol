// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract basicStorage {
    uint256 public bestNumber; //  sets default bestNumber to 0
    Cars[] public car;
    
    mapping (string => uint256) public nameTospeed;
    mapping ( uint256 => string) public speedToname;


    // struct used to create new object
    struct Cars {
        string name;
        uint256 speed;
    }

    function store(uint256 _bestNumber) public {
        bestNumber = _bestNumber;
    }

    // view keyword used to return bestNumber without consuming gas
    function retrieve() public view returns (uint256) {
        return bestNumber;
    }

    // function to add cars dynamically
    function AddCars(string memory _name, uint256 _speed) public {
        car.push(Cars(_name, _speed));
        nameTospeed[_name] = _speed;
        speedToname[_speed]= _name;
    }
}
