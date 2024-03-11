import { ethers } from "hardhat";
import { Signer } from "ethers";
import { MyNFT } from "../artifacts/contracts";

async function main() {
  const [deployer]: Signer[] = await ethers.getSigners();

  console.log("Deploying contracts...");
  const MyNFTFactory = await ethers.getContractFactory("MyNFT", deployer);
  const subscriptionId = 10060; // Imposta il valore della subscriptionId
  const vrfCoordinator = "0x8103b0a8a00be2ddc778e6e7eaa21791cd364625"; // Imposta l'indirizzo del VRFCoordinator
  const keyHash = "0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c"; // Imposta il valore del keyHash
  const callbackGasLimit = 100000; // Imposta il valore del callbackGasLimit
  const requestConfirmations = 3; // Imposta il valore del requestConfirmations
  const numWords = 1; // Imposta il valore del numWords

  const myNFT: MyNFT = await MyNFTFactory.deploy(
    subscriptionId,
    vrfCoordinator,
    keyHash,
    callbackGasLimit,
    requestConfirmations,
    numWords
  );

  await myNFT.waitForDeployment();

  console.log("MyNFT deployed to:", myNFT.getAddress());

  console.log("Minting new NFT...");
  const tokenURI = "https://example.com/metadata"; // URI del metadata del tuo token
  await myNFT.connect(deployer).requestNewRandomNFT(tokenURI);

  console.log("NFT minted successfully!");
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
