pragma solidity ^0.4.18;

import './levels/base/Level.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract Ethernaut is Ownable {

  // ----------------------------------
  // Owner interaction
  // ----------------------------------

  mapping(address => bool) registeredLevels;
  mapping(address => string) public players;

  // Only registered levels will be allowed to generate and validate level instances.
  function registerLevel(Level _level) public onlyOwner {
    registeredLevels[_level] = true;
  }

  // ----------------------------------
  // Get/submit level instances
  // ----------------------------------

  struct EmittedInstanceData {
    address player;
    Level level;
    bool completed;
  }

  mapping(address => EmittedInstanceData) emittedInstances;

  event LevelInstanceCreatedLog(address indexed player, address instance, string nickname);
  event LevelCompletedLog(address indexed player, Level level, string nickname);

  function register(string _nickname) public returns(bool) {
    if(bytes(_nickname).length > 0 && bytes(players[msg.sender]).length == 0) {
      players[msg.sender] = _nickname;
      return true;
    }
    return false;
  }

  function createLevelInstance(Level _level) public payable {

    // Ensure level is registered.
    require(registeredLevels[_level]);

    // Get level factory to create an instance.
    address instance = _level.createInstance.value(msg.value)(msg.sender);

    // Store emitted instance relationship with player and level.
    emittedInstances[instance] = EmittedInstanceData(msg.sender, _level, false);

    // Retrieve created instance via logs.
    LevelInstanceCreatedLog(msg.sender, instance, players[msg.sender]);
  }

  function submitLevelInstance(address _instance) public {

    // Get player and level.
    EmittedInstanceData storage data = emittedInstances[_instance];
    require(data.player == msg.sender); // instance was emitted for this player
    require(data.completed == false); // not already submitted

    // Have the level check the instance.
    if(data.level.validateInstance(_instance, msg.sender)) {

      // Register instance as completed.
      data.completed = true;

      // Notify success via logs.
      LevelCompletedLog(msg.sender, data.level, players[msg.sender]);
    }
  }
}
