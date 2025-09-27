const { ethers } = require("hardhat");

async function main() {
  const address = "DEPLOYED_CONTRACT_ADDRESS";
  const FeeCollectorHook = await ethers.getContractFactory("FeeCollectorHook");
  const contract = await FeeCollectorHook.attach(address);

  console.log("Fee rate:", await contract.feeRate());
}

main();