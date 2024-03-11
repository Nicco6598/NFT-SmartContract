import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-ethers";
import '@typechain/hardhat';
import "@nomicfoundation/hardhat-chai-matchers";
import * as dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL, // Assicurati che questa variabile d'ambiente sia definita nel tuo file .env
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
};

export default config;