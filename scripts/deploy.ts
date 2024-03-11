import { ethers } from "hardhat";

async function main() {
  // Sostituisci 'MyNFT' e i parametri del costruttore come necessario
  const NFTContractFactory = await ethers.getContractFactory("MyNFT");
  const subscriptionId = "10060"; 
  const nftContract = await NFTContractFactory.deploy(subscriptionId);

  await nftContract.deployed();

  console.log("MyNFT deployed to:", nftContract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});