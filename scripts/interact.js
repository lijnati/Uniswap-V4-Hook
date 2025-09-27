const { ethers } = require("hardhat");

async function main() {
  const address = "0xFbBa9C9956F14cc81C7B790106073f699E726102";
  const FeeCollectorHook = await ethers.getContractFactory("FeeCollectorHook");
  const contract = await FeeCollectorHook.attach(address);

  console.log("Fee rate:", await contract.feeRate());
}

main();