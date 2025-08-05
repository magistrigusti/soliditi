import { loadFixture, ethers, expect } from "./setup";

describe("Auction2", function() {
  async function deploy() {
    const [owner, hacker] = await ethers.getSigners();
    const auctionAmount = ethers.parseEthers("3");
    
    const Auction = await ethers.getContractFactory("Auction");
    const auction = await Auction.deploy({ value: auctionAmount });
    await auction.waitForDeployment();

    const Hack = await ethers.getContractFactory("Hack", hacker);
    const hack = await Hack.deploy(auction.target, { value: 500 });
    await hack.waitForDeployment();

    return { auction, hack, owner, auctionAmount };
  }

  it("allows to hack", async function() {
    const { auction, hack, owner, auctionAmount } = await loadFixture(deploy);

    const hackTx = await hack.connect(owner).getYourMoney();
    await hackTx.wait();

    expect(hackTx).to.changeEtherBalances(
      [auction, hack], [-auctionAmount, auctionAmount]
    );
  });
});