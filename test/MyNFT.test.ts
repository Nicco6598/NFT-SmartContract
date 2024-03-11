import { expect } from "chai";
import { ethers } from "hardhat";
import { MyNFT } from "../typechain"; // Assicurati che il percorso corrisponda alla generazione dei typechain nel tuo progetto

describe("MyNFT", function () {
  let myNFT: MyNFT;

  beforeEach(async function () {
    console.log("Deploying MyNFT contract...");
    const MyNFTFactory = await ethers.getContractFactory("MyNFT");
    const subscriptionId = 10060; // Sostituisci con il tuo ID di sottoscrizione effettivo
    const overrides = {
        gasPrice: ethers.parseUnits("35", "gwei"), // Imposta il prezzo del gas a 30 gwei
    };
    myNFT = await MyNFTFactory.deploy(subscriptionId, overrides) as MyNFT;
    await myNFT.waitForDeployment(); // Aspetta che la deploy sia completata
    console.log("MyNFT contract deployed at address:", myNFT.getAddress());
  });


  it("Should mint an NFT successfully", async function () {
    const mintTx = await myNFT.requestNewRandomNFT("tokenURI");
    await expect(mintTx).to.emit(myNFT, "RequestedRandomness");
  });

});
