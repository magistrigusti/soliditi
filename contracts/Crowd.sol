// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./utils/IERC20.sol";

contract Crowd {
  struct Campaign {
    address owner;
    uint goal;
    uint pledged;
    uint startAt;
    uint endAt;
    bool claimed;
  }

  IERC20 public immutable token;
  mapping(uint => Campaign) public campaigns;
  uint public currentId;
  mapping(uint => mapping(address => uint )) public pledges;
  uint public constant MAX_DURATION = 100 days;
  uint public constant MIN_DURATION = 10;

  event Launched(currentId, msg.sender, _goal, _startAt, _endAt);

  constructor(address _token) {
    token = IERC20(_token);
  }

  function launch(uint _goal, uint _startAt, uint _endAt) external {
    require(_startAt >= block.timestamp, "incorrect start at");
    require(_endAt >= _startAt + MIN_DURATION, "incorrect end at");
    require(_endAt <= _startAt + MAX_DURATION, "too long!");

    campaigns[currentId] = Campaign({
      owner: msg.sender,
      goal: _goal,
      pledged: 0,
      startAt: _startAt,
      endAt: _endAt,
      claimed: false
    });

    emit Launched(currentId, msg.sender, _goal, _startAt, _endAt);
    currentId += 1;
  }
}