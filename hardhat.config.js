require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {
      chainId: 1337
    },
    localhost: {
      url: "http://127.0.0.1:7545"
    },
    ganache: {
      url: "http://127.0.0.1:7545",
      accounts: ["0xea60ca493ea10dec36a6f1ad72e175099812d0838ee16b8300572b0e6ec05059"]
    }
    
  }
};