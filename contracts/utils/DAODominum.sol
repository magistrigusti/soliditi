// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ERC20.sol";
import "./ERC20Burnable.sol";

contract DAODominum is ERC20, ERC20Burnable {
  address owner;

  modifier onlyOwner() {
    require(owner == msg.sender);
    _;
  }
  constructor(address initialOwner) ERC20("DAODominum", "DOM") {
    owner = initialOwner;

    _mint(msg.sender, 10 * 10 ** decimals());
  }

  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }
}