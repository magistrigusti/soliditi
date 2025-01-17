// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IERC20Permit {
  function permit(
    address owner,
    address spender,
    uint value,
    uint deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;

  function nonces(address owner) external view returns(uint);

  function DOMAIN_SEPARATOR() external view returns(bytes32);
}