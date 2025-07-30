import { loadFixture, ethers, expect } from "./setup.ts";

describe("Auction", function() {
  async function deploy() {
    const [owner, user1, user2, hacker] = await ethers.getSigners();

    const Auction = await ethers.getContractFactory("Auction");
    const auction = await Auction.deploy();
    await auction.waitForDeployment();

    const hackerAmount = ethers.parseEther("1");

    const Hack = await ethers.getContractFactory("Hack", hacker);
    const hack = await Hack.deploy(auction.target { value: hackerAmount });
    await hack.waitForDeployment();

    return { auction, hack, owner, user1, user2, hacker, hackerAmount };
  }

  it("allows to hack", async function() {
    const { 
      auction, hack, user1, user2, hacker, hackerAmount 
    } = await loadFixture(deploy);
  });

  it("allows to hack", async function() {
    const {
      auction, hack, user1, user2, hacker, hackerAmount
    } = await loadFixture(deploy);

    const amount1 = ethers.parseEther("3");
    const amount2 = ethers.parseEther("4");

    const bid1 = await auction.connect(user1).bid({ value: amount1 });
    await bid1.wait();

    const bid2 = await auction.connect(user2).bid({ value: amount2 });
    await bid2.wait();

    expect(await auction.bids(hack.taret)).to.eq(hackerAmount);
    expect(await auction.bids(user1.address)).to.eq(amount1);
    expect(await auction.bids(user2.address)).to.eq(amount2);

    const totalBalance = hackerAmount + amount1 + amount2;

    expect(await ethers.provider.getBalance(auction.target)).to.eq(totalBalance);

    const hackTx = await hack.connect(hacker).hack();
    await hackTx.wait();

    expect(await ethers.provider.getBalance(hack.target)).to.eq(totalBalance);
    expect(await ethers.provider)
  });
});
