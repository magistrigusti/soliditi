import { loadFixture, ethers, expect } from "./setup";

describe("Game", function() {
  async function deploy() {
    const [ owner ] = await ethers.getSigners();

    const secretNumber = 42;

    const salt = ethers.solidityPackedKeccak256(
      ["string"], ["secret phrase"]
    );

    const hashedSecretNumber = ethers.solidityPackedKeccak256(
      ["address", "uint256", "bytes32"], [owner.address, secretNumber, salt]
    ); 

    const Game = await ethers.getContractFactory("Game");
    const game = await Game.deploy(secretNumber);
    await game.waitForDeployment();

    return { game, salt, secretNumber }
  }

  it("commit-reveals", async function() {
     const { game, salt, secretnumber } = await loadFixture(deploy);

     expect(await game.secretNumber()).to.eq(0);

     await expect(game.reveal(11, salt)).to.be.revertedWith("invalid reveal!");

     const xReval = await game.reveal(secretnumber, salt);
     await txReval.wait();

     expect(await game.secretNumber()).to.eq(secretNumber);
  });

});