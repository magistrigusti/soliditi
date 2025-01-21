// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./IERC20Permit.sol";
import "./ERC20.sol";
import "./utils/Counters.sol";
import "./crypto/ECDSA.sol";
import "./crypto/EIP712.sol";

abstract contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
  using Counters for Counters.Counter;

  mapping(address => Counters.Counter) private _nonces;

  bytes32 private constant _PERMIT_TYPEHASH = keccak256(
    "Permit(address owner, address spender, int256 value, uint256 nonce, uint256 deadline)"
  );

  constructor(string memory name) EIP712(name, "1") {}

  function permit(
    address owner,
    address spender,
    uint value,
    uint deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external virtual {
    require(block.timestamp <= deadline, "expired");

    bytes32 structHash = keccak256(
      abi.encode(
        _PERMIT_TYPEHASH,
        owner,
        spender,
        value,
        _useNonce(owner),
        deadline
      )
    );

    bytes32 hash = _hashTypeDataV4(structHash);
    address signer = ECDSArecver(hash, v, r, s);
    require(signer == owner, "not an owner");
    _approve(owner, spender, value);
  }

  function nonces(address owner) external view returns(uint) {
    return _nonces[owner].current();
  }

  function DOMAIN_SEPARATOR() xternal view returns(bytes32) {
    return _domainSeparatorV4();
  }

  function _useNonce(address owner) internal virtual returns(uint current) {
    Counters.Counter storage nonce = _nonces[owner];
    current = nonce.current();
    nonce.increment();
  }
}