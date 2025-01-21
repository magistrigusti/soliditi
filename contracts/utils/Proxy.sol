// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./MyToken.sol";

contract Proxy {
  function doSend(
    MyToken mtk,
    address owner,
    address spender,
    uint value,
    uint deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external [
    mtk.permit(owner, spender, value, deadline, v, r, s);
  ]
}