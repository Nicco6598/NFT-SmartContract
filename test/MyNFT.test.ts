import { ethers, network } from 'hardhat';
import { expect } from 'chai';
import { MyNFT, VRFCoordinatorV2Mock } from '../typechain-types';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe('MyNFT', function () {
  let MyNFT: MyNFT;
  let vrfCoordinatorV2Mock: VRFCoordinatorV2Mock;
  let owner: SignerWithAddress, addr1: SignerWithAddress;
  const subscriptionId = 1; // Convertito da stringa a numero
  const VRFCoordinatorV2 = "0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625";
  const gasLane = "0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c";
  const callbackGasLimit = 100000; // Placeholder, sostituire con il valore corretto
  const mintFee = ethers.parseUnits("0.1", "ether"); // Convertito in wei
  const maxTokens = 10000; // Placeholder, definire il numero massimo di token
  const chainId = network.config.chainId!;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    vrfCoordinatorV2Mock = await ethers.deployContract('VRFCoordinatorV2Mock', [
      '250000000000000000',
      1e9,
    ]);
    await vrfCoordinatorV2Mock.waitForDeployment();

    const NFTContractFactory = await ethers.getContractFactory("MyNFT");
    const MyNFT = await NFTContractFactory.deploy(
      VRFCoordinatorV2, 
      subscriptionId, 
      gasLane,
      callbackGasLimit,
      mintFee,
      maxTokens
    );
    await MyNFT.waitForDeployment();
  });

  describe('Deployment', function () {
    it('Should correctly set the initial token counter to 0 ✅', async function () {
      expect(await MyNFT.getTokenCounter()).to.equal(0);
    });

    it('Should have correct name and symbol ✅', async function () {
      expect(await MyNFT.name()).to.equal('Random On Chain NFT');
      expect(await MyNFT.symbol()).to.equal('RR');
    });
  });
});