import { DAODominum } from "../typechain-types";
import { loadFixture, ethers, expect } from "./setup";

describe("TokenEchange", function() {
  async function deploy() {
    const [owner, buyer] = await ethers.getSigners();

    const DAODominum = await ethers.getContractFactory("DAODominum");
    const dom = await DAODominum.deploy(owner.address);
    await dom.waitForDeployment();

    const TokenExchange = await ethers.getContractFactory("TokenExchange");
    const exch = await TokenExchange.deploy(dom.target);
    await exch.waitForDeployment();

    return { dom, exch, owner, buyer }
  }

  it("should allow to buy", async function() {
    const { dom, exch, owner, buyer } = await loadFixture(deploy);

    const tokensInStock = 3n;
    const tokensWithDecimals = await withDecimals(dom, tokensInStock);

    const transferTx = await dom.transfer(exch.target, tokensWithDecimals);
    await transferTx.wait();

    expect(await dom.balanceOf(exch.target)).to.eq(tokensWithDecimals);
    await expect(transferTx).to.changeTokenBalances(
      dom, [owner, exch], [-tokensWithDecimals, tokensWithDecimals]
    );

    const tokensToBuy = 1n;
    const value = ethers.parseEther(tokensToBuy.toString());

    const buyTx = await exch.connect(buyer).buy({value: value});
  });

  async function withDecimals(dom: DAODominum, value: bigint): Promise<bigint> {
    return value * 10n ** await dom.decimals();
  }
});