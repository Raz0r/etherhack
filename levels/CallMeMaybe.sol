contract CallMeMaybe {
    modifier CallMeMaybe() {
      uint32 size;
      address _addr = msg.sender;
      assembly {
        size := extcodesize(_addr)
      }
      if (size > 0) {
          revert();
      }
      _;
    }

    function HereIsMyNumber() CallMeMaybe {
        if(tx.origin == msg.sender) {
            revert();
        } else {
            msg.sender.transfer(this.balance);
        }
    }

    function() payable {}
}
