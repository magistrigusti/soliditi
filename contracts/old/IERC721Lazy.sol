// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IERC721Lazy {
  function redeem(
    address owner,
    address redeemer,
    uint tokenId,
    uint mintPrice,
    string memory uri,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;

  function DOMAIN_SEPARATOR() external view returns(bytes32);
}