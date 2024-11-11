//0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6
const hre = require("hardhat");
const ethers = hre.ethers;
const GreeterArtifact = require('../artifacts/contracts/Greeter.sol/Greeter.json');

async function main() {
  const [signer] = await ethers.getSigners();
  const greeterAddr = "0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6";

  const greeterContract = new ethers.Contract(
    greeterAddr,
    GreeterArtifact.abi,
    signer 
  );

  const setGreetResult = await greeterContract.setGreet("fuck you world");
  console.log(setGreetResult);
  await setGreetResult.wait();

  const result = await greeterContract.getGreet();
  console.log(result);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Ошибка:", error);
    process.exit(1);
  });