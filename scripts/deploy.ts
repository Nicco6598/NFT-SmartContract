import { ethers } from "hardhat";

async function main() {
  const NFTContractFactory = await ethers.getContractFactory("MyNFT");
  const subscriptionId = 1; // Convertito da stringa a numero
  const VRFCoordinatorV2 = "0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625";
  const gasLane = "0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c";
  const callbackGasLimit = 100000; // Placeholder, sostituire con il valore corretto
  const mintFee = ethers.parseUnits("0.1", "ether"); // Convertito in wei
  const maxTokens = 10000; // Placeholder, definire il numero massimo di token

  const nftContract = await NFTContractFactory.deploy(
    VRFCoordinatorV2, 
    subscriptionId, 
    gasLane,
    callbackGasLimit,
    mintFee,
    maxTokens
  );

  await nftContract.waitForDeployment();

  console.log("MyNFT deployed to:", nftContract.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
