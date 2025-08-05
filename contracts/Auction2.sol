// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Auction {
  address owner;

  modifier onlyOwner() {
    require(msg.sender == owner, "not an owner!");
    _;
  }

  constructor() payable {
    owner = msg.sender;
  }

  function withdraw(address _to) external onlyOwner {
    (bool ok, ) = _to.call{ value: address(this).balance }("");
    require(ok, "can't send");
  }

  receive() external payable {}
}

contract Hack {
  Auction toHack;

  constructor(address payable _toHack) payable {
    toHack = Auction(_toHack);
  }

  function getYourMoney() external {
    (bool ok, ) = msg.sender.call{ value: address(this).balance}("");
    require(ok, "can't send");

    toHack.withdraw(address(this));
  }

  receive() external payable {}
}