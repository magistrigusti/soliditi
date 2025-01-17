// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

interface IERC721Receiver {
  function onERC721Received(
    address operator,
    address from,
    uint tokenId,
    bytes calldata data
  ) external returns (bytes4);
}