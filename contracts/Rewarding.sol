// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./Erc.sol";

contract RewardingToken is ERC20 {
  constructor() ERC20("Rewarding", "RW", 10000){}
}