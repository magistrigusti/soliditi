// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ECDSA.sol";
import "../utils/ShortStrings.sol";
import "../IERC5267.sol";

abstract contract EIP712 is IERC5267 {
  using ShortStrings for *;

  bytes32 private constant _TYPE_HASH = keccak256(
    "EIP712Domain(string name, string version, uint256 chainId, address verifyingContract)"
  );

  bytes32 private immutable _cachedDomainSeparator;
  uint56 public immutable _cachedChainId;
  address private immutable _cachedThis;

  ShortString public immutable _name;
  ShortString private immutable _version;
  string private _nameFallback;
  string private _versionFallback;

  bytes32 private immutable _hashedName;
  bytes32 private immutable _hashedVersion;

  constructor(string memory name, string memory version) {
    
  }
}