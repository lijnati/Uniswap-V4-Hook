const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying FeeCollectorHook...");

  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);
  console.log("Account balance:", (await ethers.provider.getBalance(deployer.address)).toString());

  const FeeCollectorHook = await ethers.getContractFactory("FeeCollectorHook");
  const feeCollectorHook = await FeeCollectorHook.deploy();
  
  await feeCollectorHook.waitForDeployment();
  const address = await feeCollectorHook.getAddress();

  console.log("FeeCollectorHook deployed to:", address);
  console.log("Initial fee rate:", await feeCollectorHook.feeRate(), "basis points");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });