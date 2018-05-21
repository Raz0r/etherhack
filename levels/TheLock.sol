pragma solidity ^0.4.18;

contract TheLock {
    bool public unlocked;

    function TheLock() public {
      unlocked = false;
    }

    function unlock(bytes4 pin) public payable returns(bool) {
        require(msg.value >= 0.5 ether);
        uint result;
        uint sum;
        for (uint8 i = 0; i < 4; i++) {
            uint c = uint(pin[i]);
            if (c >= 48 && c <= 57) {
                uint digit = c - 48;
                sum += digit ** 4;
                result = result * 10 + digit;
            }
        }
        if(sum == result) {
            unlocked = true;
            return true;
        }
        return false;
    }
}
