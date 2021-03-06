pragma solidity ^0.4.18;

import './base/Level.sol';
import './Azino777.sol';

contract WeakRandomFactory is Level {

  uint public insertCoin = 0.1 ether;

  function createInstance(address _player) public payable returns (address) {
    _player;
    require(msg.value >= insertCoin);
    Azino777 instance = new Azino777();
    require(this.balance >= insertCoin);
    instance.transfer(insertCoin);
    return instance;
  }

  function validateInstance(address _instance, address _player) public constant returns (bool) {
    _player;
    Azino777 instance = Azino777(_instance);
    return instance.balance == 0;
  }

  function() public payable {}
}
