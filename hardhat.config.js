require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require('dotenv').config();

task("account", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks: {
    // localhost: { url: "http://127.0.0.1:8545" },
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.API_KEY}`,
      account: [process.envAPI_KEY],
    },
    hardhat: {
      chainId: 1337
    }
  }
};
