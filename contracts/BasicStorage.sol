// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract BasicStorage {
    uint256 public bestNumber; //  sets default bestNumber to 0
    Cars[] public car;
    
    mapping (string => uint256) public nameTospeed;
    mapping ( uint256 => string) public speedToname;


    // struct used to create new type
    struct Cars {
        string name;
        uint256 speed;
    }

    function store(uint256 _bestNumber) public virtual {
        bestNumber = _bestNumber;
    }

    // view keyword used to return bestNumber without consuming gas
    function retrieve() public view returns (uint256) {
        return bestNumber;
    }

    // dynamic function to add cars
    function AddCars(string memory _name, uint256 _speed) public {
        car.push(Cars(_name, _speed));
        nameTospeed[_name] = _speed;
        speedToname[_speed]= _name;
    }
}
