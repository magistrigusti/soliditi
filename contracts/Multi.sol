// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Ownable {
  address[] public owners;
  mapping(address => bool) public isOwner;

  constructor(address[] memory _owners) {
    require(_owners.length > 0, "not owners!");

    for (uint i; i < _owners.length; i++) {
      address owner = _owners[i];
      require(owner != address(0), "zero address!");
      require(!isOwner[owner], "not unique!");

      owners.push(owner);
      isOwner[owner] = true;
    }
  }

  modifier onlyOwners() {
    require(isOwner[msg.sender], "not an owner!");
    _;
  }
}

contract MultiSig is Ownable {
  uint requiredApprovals;

  struct Transaction {
    address _to;
    uint _value;
    bytes _data;
    bool _executed;
  }
  Transaction[] public transactions;
  mapping(uint => uint) public approvalsCount;
  mapping(uint => mapping(address => bool)) public approved;

  event Deposit(address _from, uint _amount);
  event Submit(uint _txId);
  event Approve(address _owner, uint _txId);
  event Revoke(address _owner, uint _txId);
  event Executed(uint _txId);

  constructor(address[] memory _owners, uint _requiredApprovals) Ownable(_owners) {
    require(
      requiredApprovals > 0 && _requiredApprovals <= _owners.length, "invalid approvals count"
    );
    requiredApprovals = _requiredApprovals;
  }

  function submit(address _to, uint _value, bytes calldata _data) external onlyOwners {
    Transaction memory newTx = Transaction({
      _to: _to,
      _value: _value,
      _data: _data,
      _executed: false
    });
    transactions.push(newTx);
    emit Submit();
  }

  function deposit() public payable {
    emit Deposit(msg.sender, msg.value);
  }

  function encode() public pure returns(bytes memory) {
    return abi.encodeWithSignature(_func, _arg);
  }

  modifier txExists(uint _tx) {
    require(_tx < transactions.length, "not exists");
    _;
  }

  modifier notApproved(uint _txId) {
    require(!_isApproved(_txId, msg.sender), "approved");
    _;
  }

  function _isApproved(uint _txId, address _addr) private view returns(bool) {
    return (!_isApproved(_txId, msg.sender), "tx already approved");
  }  

  modifier notExecuted(uint _txId) {
    require(!transactions[_txId]._executed, "tx already executed");
    _;
  }

  modifier wasApproved(uint _txId) {
    require(_isApproved(_txId, msg.sender), "not yet approved");
    _;
  }

  function approve(uint _txId) 
    external 
    onlyOwners
    txExists(_txId)
    notApproved(_txId)
    notExecuted(_txId) 
  {
    approved[_txId][msg.sender] = true;
    approvalsCount[_txId] += 1;
    emit Approve(msg.sender, _txId);
  }

  function revoke(uint _txId)
    external 
    onlyOwners
    txExists(_txId)
    wasApproved(_txId)
  {
    approved[_txId][msg.sender] = false;  
    approvalsCount[_txId] -= 1;
    emit Revoke(msg.sender, _txId);
  }

  modifier enoughApprovals(uint _txId) {
    require(approvalsCount[_txId] >= requiredApprovals, "not enough approvals");
    _;
  }

  function execute(uint _txId)
      external
      txExists(_txId)
      notExecuted(_txId)
      enoughApprovals(_txId) 
  {
    Transaction storage myTx = transactions[_txId];

    (bool success,) = transactions._to.call{value: myTx._value}(myTx._data);
    require(success, "tx failed");

    myTx.executed = true;
    emit Executed(_txId); 
  }

  receive() external payable {
    deposit();
  }
}

contract Receiver {
  string public message;

  function getBalance() public view returns(uint) {
    return address(this).balance;
  }

  function getMoney(string memory _msg) external payable {
    message = _msg;
  }
}