// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "./IERC721Metadata.sol";

contract ERC721 is IERC721Metadata {
  string public name;
  string public symbol;
  mapping(address => uint) _balances;
  mapping(uint => address) _owners;
  mapping(uint => address) _tokenApprovals;
  mapping(address => mapping(address => bool)) _operatorApprovals;

  modifier _requireMinted(uint tokenId) {
    require(_exists(tokenId), "not minted");
    _;
  }

  constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
  }

  function transferFrom(address from, address to, uint tokenId) external {
    require(_isApprovedOrOwner(msg.sender, tokenId), "not an owner or approved!");
    _transfer(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint tokenId) external {

  }

  function ownerOf(uint tokeId) public view _requireMinted(tokenId) returns(address) {
    return _owners[tokenId];
  }

  function _isApprovedForAll(address owner, address operator) external view returns(bool) {
    
  }

  function _isApprovedOrOwner(address spender, uint tokenId) internal view returns(bool) {
    address owner = ownerOf(tokenId);

    require(
      spender == owner ||
      isApprovedForAll(owner, spender) ||
      getApproved(tokenId) == spender,
      "not an owner or approved!"
    );
  }

  function _exists(uint tokenId) internal view returns(bool) {
    return _owners[tokenId] != address(0);
  }

}