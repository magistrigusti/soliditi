// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./Erc.sol";

contract StakingToken is ERC20 {
  constructor() ERC20("Staking", "ST", 10000) {}
}