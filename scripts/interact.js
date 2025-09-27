const { ethers } = require("hardhat");

async function main() {
  const address = "0x6d4889E0fA82d74E2DfcF47c86559EB12b85dbB7";
  const FeeCollectorHook = await ethers.getContractFactory("FeeCollectorHook");
  const contract = await FeeCollectorHook.attach(address);

  console.log("Fee rate:", await contract.feeRate());
}

main();