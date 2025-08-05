// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Game {
  uint256 public secretNumber;
  bytes32 public hashedSecretNumber;

  constructor(bytes32 _hashedSecretNumber) {
    hashedSecretNumber = _hashedSecretNumber;
  }

  function reveal(uint _secretNumber, bytes32 _salt) external {
    bytes32 commit = keccak256(abi.encodePacked(
      msg.sender, _secretNumber, _salt
    ));

    require(commit == hashedSecretNumber, "invalid reveal!");

    secretNumber = _secretNumber;
  }
}