const hre = require('hardhat');
const ethers = hre.ethers;

async function main() {
  const Greeter = await ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy();

  await greeter.waitForDeployment();

  console.log("Адрес контракта:", await greeter.getAddress());
}

main().catch((error) => {
  console.error("Ошибка:", error);
  process.exit(1);
});
