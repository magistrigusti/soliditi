import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts} = hre;
  const { deploy } = deployments;
  const { deployer, get } = await getNamedAccounts();
  const toen = await get("MyToken");

  await deploy("Governance", {
    from: deployer,
    args: [],
    log: true
  });
}

export default func;