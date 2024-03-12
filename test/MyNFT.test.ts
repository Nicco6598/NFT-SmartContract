import { ethers, network } from 'hardhat';
import { expect } from 'chai';
import { MyNFT, VRFCoordinatorV2Mock } from '../typechain-types';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe('MyNFT', function () {
  let MyNFT: MyNFT;
  let vrfCoordinatorV2Mock: VRFCoordinatorV2Mock;
  let owner: SignerWithAddress, addr1: SignerWithAddress;
  const subscriptionId = 1;
  const chainId = network.config.chainId!;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    vrfCoordinatorV2Mock = await ethers.deployContract('VRFCoordinatorV2Mock', [
      '250000000000000000',
      1e9,
    ]);
    await vrfCoordinatorV2Mock.waitForDeployment();

    MyNFT = await ethers.deployContract('MyNFT');
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