import { ethers } from "hardhat";
import { expect } from "chai";
import { MyNFT } from "../typechain-types"; // Assicurati che il percorso sia corretto per i tuoi file generati

describe("MyNFT", function () {
  let myNft: MyNFT;
  let owner: any;
  let addr1: any;
  let addrs: any;

  beforeEach(async function () {
    // Recupera gli account dal provider
    [owner, addr1, ...addrs] = await ethers.getSigners();

    // Qui, si presuppone che il contratto sia già deployato. Sostituisci 'myNftAddress' con l'indirizzo del tuo contratto deployato
    const myNftAddress = "inserisci_qui_l_indirizzo_del_contratto";
    myNft = await ethers.getContractAt("MyNFT", myNftAddress) as MyNFT;
  });

  describe("Minting", function () {
    it("Should mint an NFT to the owner", async function () {
      const tokenURI = "http://mytokenlocation.com";
      await myNft.requestNewRandomNFT(tokenURI);
      expect(await myNft.ownerOf(0)).to.equal(owner.address);
    });
  });

  describe("Transferring", function () {
    it("Should transfer an NFT from owner to another account", async function () {
      const tokenURI = "http://mytokenlocation.com";
      await myNft.requestNewRandomNFT(tokenURI);

      // Prima del trasferimento
      expect(await myNft.ownerOf(0)).to.equal(owner.address);

      // Trasferimento
      await myNft["safeTransferFrom(address,address,uint256)"](owner.address, addr1.address, 0);

      // Dopo il trasferimento
      expect(await myNft.ownerOf(0)).to.equal(addr1.address);
    });

    it("Should fail if non-owner tries to transfer an NFT", async function () {
      const tokenURI = "http://mytokenlocation.com";
      await myNft.requestNewRandomNFT(tokenURI);

      // Tentativo di trasferimento da un account che non è il proprietario
      await expect(myNft.connect(addr1)["safeTransferFrom(address,address,uint256)"](owner.address, addr1.address, 0))
        .to.be.revertedWith("ERC721: transfer caller is not owner nor approved");
    });
  });
});
