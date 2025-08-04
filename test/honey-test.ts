import { loadFixture, ethers, expect } from "./setup";
import type { Bank, HoneyPot} from "../typechain-types"

describe("Honey", function() {
  async function dep() {
    const HoneyPotFactory = await ethers.getContractFactory("HoneyPot");
    const honeypot: HoneyPot = await HoneyPotFactory.deploy();
    await honeypot.deployed();

    const BankFactory = await ethers.getContractFactory("Bank");
    const bank: Bank = await BankFactory.deploy(honeypot.address);
    await bank.deployed();

    return { honeypot, bank }
  }

  it('honeypots', async function() {
    const { bank } = await loadFixture(dep);

    const tx = await bank.deposit({ value: 1000 });
    await tx.wait();

    await expect(bank.withdraw(100)).to.be.reverted;
  });
});