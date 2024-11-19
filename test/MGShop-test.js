const { expect } = require("chai");
const { ethers } = require("hardhat");
const tokenJSON = require("../artifacts/contracts/AucEngine.sol/AucEngine.dbg.json");

describe("MGShop", function() {
  let owner;
  let buyer;
  let shop;

  beforeEach(async function() {
    [owner, buyer] = await ethers.getSigners();

    const MGShop = await ethers.getContractFactory("MGShop", owner);
    shop = await MGShop.deploy();
    await shop.deployed();
  });

  it("shold have an owner and a token", async function() {
    expect(await shop.owner()).to.eq(owner.address);

    expect(await shop.token()).to.be.properAddress;
  });

  it("allows to buy", async function() {
    const tokenAmount = 3;

    const txData= {
      value: tokenAmount,
      to: shop.address
    };

    const tx = await buyer.sendTransaction(txData);
    await tx.wait();

    
  })
});