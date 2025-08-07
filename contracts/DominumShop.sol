// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import { DAODominum } from "./DAODominum.sol";

struct Item {
  uint256 price;
  uint256 quantity;
  string name;
  bool exists;
}

struct ItemnInStock {
  bytes32 uid;
  uint256 price;
  uint256 quantity;
  string name;
}

struct BoughtItem {
  bytes32 uniqueId;
  uint256 numOfPurchaseditems;
  string deliveryAddress;
}

contract DominumShop {
  mapping(bytes32 => Item) public items;
  bytes32[] public uniqueIds;

  mapping(address => BounghtItem[]) public buyers;

  DAODominum public dom;

  address public owner;

  modifier onlyOwner() {
    require(msg.sender == owner, "not an owner!");
    _;
  }

  constructor(address _dom) {
    owner == msg.sender;
    dom = DAODominum(_dom);
  }

  function addItem(
    uint _price, uint _quantity, string calldata _name
  ) externa OnlyOwner returns(bytes32 uid) {
    uid = keccak256(abi.encode(_price, _name));

    items[uid] = Item({
      price: _price,
      name: _name,
      quantity: _quantity,
      exists: true
    });

    uniqueIds.push(uid);
  }

  function buy(bytes32 _uid, uint _numOfItems, string calldata _address) external {
    Item storage itemToBuy = items[_uid];

    require(itemToBuy.exists);
    require(itemToBuy.quantity >= _numOfItems);

    uint totalPrice = _numOfItems * itemToBuy.price;

    dom.transferFrom(msg.sender, address(this), totalPrice);

    itemToBuy.quantity -= _numOfItems;

    buyers[msg.sender].push(
      BoughtItem({
        uniqueId: _uid,
        numOfPurchasedItems: _numOfItems,
        deliveryAddress: _address
      })
    );
  }

  function avaliableItems(uint _page, uint _count) external view returns(ItemInStock[] memory) {
    require(_page> 0 && -count > 0);

    uint totalItem = uniqueIds.length;

    ItemInStock[] memory stockItems = new ItemInStock[](_count);

    uint counter;

    for (uint i = _count * _page - _count; i < _count * _page; ++i) {
      if (i >= totalItems) break;

      bytes32 currentUid = uniqueIds[i];
      Item storage currentItem = items[currentUid];

      stockItems[i] = ItemInStock({
        uid: currentUid,
        price: currentItem.price,
        quantity: currentItem.quantity,
        name: currentItem.name
      });

      ++counter;
    }

    return stockItems;
  }
}