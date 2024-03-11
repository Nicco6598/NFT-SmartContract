// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract MyNFT is ERC721URIStorage, Ownable(msg.sender), VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;

    // VRF Variables
    uint64 s_subscriptionId;
    address vrfCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625 ;
    bytes32 keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c ;
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
            tokenCounter = 5;
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

}
