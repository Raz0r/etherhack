pragma solidity ^0.4.16;

contract PrivateRyan {
  uint private seed = 1;

  function PrivateRyan() {
    seed = rand(256);
  }

  function spin(uint256 bet) public payable {
    require(msg.value >= 0.01 ether);
    uint256 num = rand(100);
    seed = rand(256);
    if(num == bet) {
        msg.sender.transfer(this.balance);
    }
  }

  //Generate random number between 0 & max
  uint256 constant private FACTOR =  1157920892373161954235709850086879078532699846656405640394575840079131296399;
  function rand(uint max) constant private returns (uint256 result){
    uint256 factor = FACTOR * 100 / max;
    uint256 blockNumber = block.number - seed;
    uint256 hashVal = uint256(block.blockhash(blockNumber));

    return uint256((uint256(hashVal) / factor)) % max;
  }

  function() public payable {}
}
