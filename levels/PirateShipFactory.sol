pragma solidity ^0.4.18;

import './base/Level.sol';
import './PirateShip.sol';

contract PirateShipFactory is Level {

  function createInstance(address _player) public payable returns (address) {
    _player;
    PirateShip instance = new PirateShip();
    return instance;
  }

  function validateInstance(address _instance, address _player) public constant returns (bool) {
    _player;
    PirateShip instance = PirateShip(_instance);
    return instance.blackJackIsHauled();
  }

  function() public payable {}
}
