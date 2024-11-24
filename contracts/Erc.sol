// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import "./IERC20.sol";

contract ERC20 is IERC20 {
  uint256 totalTokens;  // Изменено на uint256
  address owner;
  mapping(address => uint256) balances;  // Изменено на uint256
  mapping(address => mapping(address => uint256)) allowances;
  string _name;
  string _symbol;

  function name() external view returns (string memory) {
    return _name;
  }

  function symbol() external view returns (string memory) {
    return _symbol;
  }

  function decimals() external pure returns (uint8) {
    return 18;
  }

  function totalSupply() external view returns (uint256) {
    return totalTokens;
  }

  modifier enoughTokens(address _from, uint256 _amount) {
    require(balanceOf(_from) >= _amount, "Not enough tokens");
    _;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Not an owner!");
    _;
  }

  constructor(
    string memory name_, 
    string memory symbol_, 
    uint256 initialSupply,
    address shop
  ) {
    _name = name_;
    _symbol = symbol_;
    owner = msg.sender;
    mint(initialSupply, shop);
  }

  function balanceOf(address account) public view returns (uint256) {
    return balances[account];
  }

  function transfer(address to, uint256 amount) external enoughTokens(msg.sender, amount) returns (bool) {
    _beforeTokenTransfer(msg.sender, to, amount);  
    balances[msg.sender] -= amount;
    balances[to] += amount;
    emit Transfer(msg.sender, to, amount);
    return true;  // Возвращаемое значение bool
  }
 
  function mint(uint256 amount, address shop) public onlyOwner {
    _beforeTokenTransfer(address(0), shop, amount);
    balances[shop] += amount;
    totalTokens += amount;  
    emit Transfer(address(0), shop, amount);
  }

  function burn(address _from, uint256 amount) public onlyOwner {
    _beforeTokenTransfer(_from, address(0), amount);
    balances[_from] -= amount;
    totalTokens -= amount;
    emit Transfer(_from, address(0), amount);
  }

  function allowance(address _owner, address spender) public view returns (uint256) {
    return allowances[_owner][spender];
  }
    
  function approve(address spender, uint256 amount) public returns (bool) {
    _approve(msg.sender, spender, amount);
    return true;  // Возвращаемое значение bool
  }

  function _approve(address sender, address spender, uint256 amount) internal virtual {
    allowances[sender][spender] = amount;
    emit Approval(sender, spender, amount);  // Исправлено: Approve на Approval
  }

  function transferFrom(address sender, address recipient, uint256 amount) public enoughTokens(sender, amount) returns (bool) {
    _beforeTokenTransfer(sender, recipient, amount);
    allowances[sender][msg.sender] -= amount;  // Исправлено: изменен recipient на msg.sender
    balances[sender] -= amount;
    balances[recipient] += amount;
    emit Transfer(sender, recipient, amount);
    return true;  // Возвращаемое значение bool
  }

  function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {
    // Вставьте любые нужные действия до передачи токенов
  }
}

contract MagistriGusti is ERC20 {
  constructor(address shop) ERC20("MagistriGusti", "MG", 1000, shop) {}
}

contract MGShop {
  IERC20 public token;
  address payable public owner;
  event Bought(uint256 _amount, address indexed _buyer);
  event Sold(uint256 _amount, address indexed _seller);

  constructor() {
    token = new MagistriGusti(address(this));
    owner = payable(msg.sender);
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "not an owner");  // Исправлено: = на ==
    _;
  }

  function sell(uint256 _amountToSell) external {
    require(
      _amountToSell > 0 && token.balanceOf(msg.sender) >= _amountToSell,
      "incorrect amount!"
    );

    uint256 allowance = token.allowance(msg.sender, address(this));
    require(allowance >= _amountToSell, "check allowance!");

    token.transferFrom(msg.sender, address(this), _amountToSell);

    payable(msg.sender).transfer(_amountToSell);

    emit Sold(_amountToSell, msg.sender);
  }

  receive() external payable {
    uint256 tokensToBuy = msg.value;
    require(tokensToBuy > 0, "not enough funds");

    require(tokenBalance() >= tokensToBuy, "not enough tokens");

    token.transfer(msg.sender, tokensToBuy);
    emit Bought(tokensToBuy, msg.sender);
  }

  function tokenBalance() public view returns (uint256) {
    return token.balanceOf(address(this));
  }
}

