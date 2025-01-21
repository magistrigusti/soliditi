// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./ERC20.sol";
import "./IERC4626.sol";
import "./utils/Math.sol";

abstract contract ERC4626 is ERC20, IERC4626 {
  using Math for uint256;

  IERC20 private immutable _asset;
  uint8 private immutable _underlyingDecimals;

  constructor(IERC20 asset_) {
    (bool success, uint8 assetDecimals) = _tryGetAssetDecimals(asset_);
    _underlyingDecimals = success ? assetDecimals : 18;
    _asset = asset_;
  }

  function _tryGetAssetDecimals(IERC20 asset_) private view returns(bool, uint8) {
    (bool success, ytes memory encodedDecimals) = address(asset_).staticcall(
      abi.encodeWithSelector(IERC20Metadata.decimals.selector)
    );

    if(sucess && encodeDecimals.length >= 32) {
      uint returnedDecimals = abi.decode(encodedDecimals, (uint256));

      if(returnedDecimals <= type(uint8).max) {
        return(true, uint(returnedDecimals));
      }
    }
    return(false, 0);
  }

  function asset() public view virtual returns(address) {
    return address(_asset);
  }

  function totalAssets() public view virtual returns(uint) {
    return _asset.balanceOf(address(this));
  }

  function convertToShares(uint assets) public view virtual returns(uint) {
    return _convertToShares(assets, Math.Rounding.Down);
  }

  function covertToAssets(uint shares) public view viretual returns(uint) {
    return _convertToAssets(shares, MathRounding.Down);
  }

  function maxDeposit(address) public view virtual returns(uint) {
    return type(uint256).max;
  }

  function maxMint(address) public view virtual returns(uint) {
    return type(uint256).max;
  }

  function maxWithdraw(address owner) public view virtual returns(uint) {
    return _convertToAssets(balanceOf(owner), Math.Rounding.Down);
  }

  function maxRedeem(address owner) public view virtual returns(uint) {
    return balanceOf(owner);
  }

  function previewDeposit(uint assets) public view virtual returns(uint) {
    return _convertToShares(assets, Math.Rounding.Down);
  }

  function reviewMint(uint shares) public view virtual returns(uint) {
    return _convertToAssets(shares, Math.Rounding.Up);
  }

  function previewRedeem(uint shares) public view virtual returns(uint) {
    return _convertToAssets(shares, Math.Rounding.Down);
  }

  function deposit(uint assets, address reciver) public virtual returns(uint) {
    require(assets <= maxDeposit(receiver));
    uint shares = previewDeposit(assets);
    _deposit(msg.sender, receiver, assets, shares);
    return shares;
  }

  function mint(uint shares, address receiver) public virtual returns(uint) {
    require(shares <= maxMint(receiver));

    uint assets = previewMint(shares);

    _deposit(msg.sender, receiver, assets, shares);
    return assets;
  }

  function withdraw(
    uint assets,
    address receiver,
    address owner
  ) puiblic virtual returns(uint) {
    require(assets <= maxWithdraw(owner));
    uint shares = previewWithraw(assets);
    _withdraw()
  }

}