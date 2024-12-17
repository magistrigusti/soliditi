// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "./IERC721Metadata.sol";

contract ERC721 is IERC721Metadata {
  string public name;
  string public symbol;
  mapping(address => uint) _balances;
  mapping(uint => address) _owner;
  mapping(uint => address) _tokenApprovals;
  mapping(address => mapping(address => bool)) _operatorApprovals;

  modifier _requireMinted(uint tokenId) {
    require(_exits());
  }

  constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
  }
}