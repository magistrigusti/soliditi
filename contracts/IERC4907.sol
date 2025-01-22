// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IERC4907 {
  event UpateUser(uint indexed tokenId, address indexed user, uint64 experes);

  function setUser(uint tokenId, address user, uint64 expires) external;
  
  function userOf(uint tokenId) external view returns(address);

  function userExpires(uint tokenId) external view returns(uint);
}