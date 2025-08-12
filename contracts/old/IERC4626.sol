// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.28;

// import "./IERC20.sol";
// import "./IERC20Metadata.sol";

// interface IERC4626 is IERC20, IERC20Metadata {
//   event Deposit(
//     address indexed sender,
//     address indexed owner,
//     uint assets,
//     uint shares
//   );

//   event Withdraw(
//     address indexed sender,
//     address indexed receiver,
//     address indexed owner,
//     uint assets,
//     uint shares
//   );

//   function asset() external view returns(address assetTokenAddress);

//   function totalAssets() external view returns(uint totalManagedAssets);

//   function convertToShares(uint assets) external view returns(uint shares);

//   function convertToAssets(uint shares) external view returns(uint assets);

//   function maxDeposit(address receiver) external view returns(uint maxAssets);

//   function previewDeposit(uint assets) external view returns(uint shares);

//   function deposit(uint assets, address receiver) external returns(uint shares);

//   function maxMint(address receiver) external view returns(uint maxShares);

//   function previewMint(uint shares) external view returns(uint assets);

//   function mint(uint shares, address receiver) external returns(uint assets);

//   function maxWithdraw(address owner) external view returns(uint maxAssets);

//   function previewWithdraw(uint assets) external view returns(uint shares); 

//   function withdraw(uint assets, address receiver, address owner) external returns();

//   function maxRedeem(address owner) external view returns(uint maxShares);

//   function previewReddem(uint shares) external view returns(uint assets);

//   function redeem(uint shares, address receiver, address owner) external returns()
// }