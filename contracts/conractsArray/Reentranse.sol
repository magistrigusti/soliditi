// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sample {
  mapping(address => uint) refunds;

  function refund() external {
    (bool ok,) = msg.sender.call{value: refunds[msg.sender]}("");
    require(ok);
    refunds[msg.sender] = 0;
  }
}

contract Hack {
  function hack(Sample _toHack) external {
    _toHack.refund();
  }

  receive() external payable {
    // _toHack.refund();
  }
}