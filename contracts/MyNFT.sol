// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract MyNFT is ERC721URIStorage, Ownable, VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;

    // VRF Variables
    uint64 s_subscriptionId;
    address vrfCoordinator = 0xYourVrfCoordinatorAddress;
    bytes32 keyHash = 0xYourKeyHash;
    uint32 callbackGasLimit = 100000;
    uint16 requestConfirmations = 3;
    uint32 numWords =  1;

    // Mapping from token ID to the random number
    mapping(uint256 => uint256) public tokenIdToRandomNumber;
    uint256 public tokenCounter;

    // Events
    event RequestedRandomness(uint256 requestId, uint256 tokenId);
    event MintedNFT(uint256 tokenId, uint256 randomNumber);

    constructor(uint64 subscriptionId) 
        VRFConsumerBaseV2(vrfCoordinator)
        ERC721("MyNFT", "MNFT") {
            COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
            s_subscriptionId = subscriptionId;
            tokenCounter = 0;
    }

    function requestNewRandomNFT(string memory tokenURI) public onlyOwner {
        uint256 tokenId = tokenCounter;
        uint256 requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        emit RequestedRandomness(requestId, tokenId);
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenCounter += 1;
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        uint256 tokenId = tokenCounter - 1;
        tokenIdToRandomNumber[tokenId] = randomWords[0];
        emit MintedNFT(tokenId, randomWords[0]);
    }

    // Add any additional functions here (e.g., transfer NFT)
}
