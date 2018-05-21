pragma solidity ^0.4.18;

import './base/Level.sol';
import './TheLock.sol';

contract TheLockFactory is Level {

  function createInstance(address _player) public payable returns (address) {
    _player;
    TheLock instance = new TheLock();
    return instance;
  }

  function validateInstance(address _instance, address _player) public constant returns (bool) {
    _player;
    TheLock instance = TheLock(_instance);
    return instance.unlocked();
  }

  function() public payable {}
}
