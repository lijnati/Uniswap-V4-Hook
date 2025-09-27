const { ethers } = require("hardhat");

async function main() {
    const address = "0xFbBa9C9956F14cc81C7B790106073f699E726102"
    const FeeCollectorHook = await ethers.getContractFactory("FeeCollectorHook");
     const feeCollectorHook = await FeeCollectorHook.attach(address);

  // Read fee rate
  console.log("Fee rate:", (await feeCollectorHook.feeRate()).toString());

  // Set fee rate (if owner)
  // await feeCollectorHook.setFeeRate(20);
}

main();