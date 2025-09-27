const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("FeeCollectorHook", function () {
  let feeCollectorHook;
  let owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    
    const FeeCollectorHook = await ethers.getContractFactory("FeeCollectorHook");
    feeCollectorHook = await FeeCollectorHook.deploy();
    await feeCollectorHook.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await feeCollectorHook.owner()).to.equal(owner.address);
    });

    it("Should set initial fee rate to 10 basis points", async function () {
      expect(await feeCollectorHook.feeRate()).to.equal(10);
    });
  });

  describe("Fee Management", function () {
    it("Should allow owner to update fee rate", async function () {
      await feeCollectorHook.setFeeRate(20);
      expect(await feeCollectorHook.feeRate()).to.equal(20);
    });

    it("Should not allow non-owner to update fee rate", async function () {
      await expect(
        feeCollectorHook.connect(addr1).setFeeRate(20)
      ).to.be.revertedWithCustomError(feeCollectorHook, "OwnableUnauthorizedAccount");
    });

    it("Should not allow fee rate above 10%", async function () {
      await expect(
        feeCollectorHook.setFeeRate(1001)
      ).to.be.revertedWith("Fee rate too high");
    });
  });

  describe("Hook Functions", function () {
    it("Should return correct selector for beforeSwap", async function () {
      const poolKey = {
        currency0: ethers.ZeroAddress,
        currency1: ethers.ZeroAddress,
        fee: 3000,
        tickSpacing: 60,
        hooks: await feeCollectorHook.getAddress()
      };
      
      const swapParams = {
        zeroForOne: true,
        amountSpecified: ethers.parseEther("1"),
        sqrtPriceLimitX96: 0
      };

      const result = await feeCollectorHook.beforeSwap(
        owner.address,
        poolKey,
        swapParams,
        "0x"
      );
      
      expect(result).to.equal(feeCollectorHook.interface.getFunction("beforeSwap").selector);
    });
  });
});