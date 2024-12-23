// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "./IERC721.sol";

interface IERC721Enumerable is IERC721 {
  function totalSupply() external view returns(uint);

  function tokenOfOwnableByIndex(address owner, uint index)
  external view returns(uint);

  function tokenByIndex(uint index) external view returns(uint);
}