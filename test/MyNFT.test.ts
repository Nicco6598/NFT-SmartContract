import { ethers } from "hardhat";
import { expect } from "chai";
import { MyNFT } from "../typechain-types"; // Assicurati che il percorso sia corretto per i tuoi file generati

describe("MyNFT", function () {
  let myNft: MyNFT;
  let owner: any;

  beforeEach(async function () {
    // Recupera l'account dal provider
    [owner] = await ethers.getSigners();
    console.log("owner: ", owner);

    // Qui, si presuppone che il contratto sia già deployato. Sostituisci 'myNftAddress' con l'indirizzo del tuo contratto deployato
    const myNftAddress = "0x25a1e093ca3587A0eb54bCC9dE4B96633523CB73";
    myNft = await ethers.getContractAt("MyNFT", myNftAddress) as MyNFT;
  });

  describe("Minting", function () {
    it("Should mint an NFT to the owner", async function () {
      const tokenURI = "ipfs://MyNFTYoga/";
      const tx = await myNft.requestNewRandomNFT(tokenURI, { gasLimit: "500000" });
      await tx.wait(); // Aspetta la conferma della transazione
      expect(await myNft.ownerOf(0)).to.equal(owner.address);
    });
  });
});