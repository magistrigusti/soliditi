import hre, { ethers } from "hardhat";

async function main() {
  const [signer] = await ethers.getSigners();

  const DAODominum = await ethers.getContractFactory("DAODominum");
  const dom = await DAODominum.deploy(signer.address);
  await dom.waitForDeployment();

  const TokenExchang = await ethers.getContractFactory("TokenExchange");
  const exch = await TokenExchang.deploy(dom.target);
  await exch.waitForDeployment();

  console.log(`Token: ${dom.target}`);
  console.log(`Exchange: ${exch.target}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1)
  })