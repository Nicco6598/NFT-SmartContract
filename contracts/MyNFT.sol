// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract MyNFT is ERC721URIStorage, Ownable(msg.sender), VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface private COORDINATOR;
    uint256 private s_subscriptionId;
    uint256 private tokenCounter;
    bytes32 private keyHash;
    uint256 private callbackGasLimit;
    uint256 private requestConfirmations;
    uint256 private numWords;

    mapping(uint256 => uint256) private tokenIdToRandomNumber;

    event RequestedRandomness(uint256 requestId, uint256 tokenId, address requester);
    event MintedNFT(uint256 tokenId, uint256 randomNumber);

    constructor(uint256 subscriptionId, address _vrfCoordinator, bytes32 _keyHash, uint256 _callbackGasLimit, uint256 _requestConfirmations, uint256 _numWords) 
        ERC721("MyNFT", "MNFT")
        VRFConsumerBaseV2(_vrfCoordinator)
    {
        s_subscriptionId = subscriptionId;
        COORDINATOR = VRFCoordinatorV2Interface(_vrfCoordinator);
        keyHash = _keyHash;
        callbackGasLimit = _callbackGasLimit;
        requestConfirmations = _requestConfirmations;
        numWords = _numWords;
        tokenCounter = 0;
    }

function requestNewRandomNFT(string memory tokenURI) external onlyOwner {
    uint256 tokenId = tokenCounter;
    uint64 subscriptionId64 = uint64(s_subscriptionId); // Converti uint256 in uint64
    uint16 requestConfirmations16 = uint16(requestConfirmations); // Converti uint256 in uint16
    uint32 callbackGasLimit32 = uint32(callbackGasLimit); // Converti uint256 in uint32
    uint32 numWords32 = uint32(numWords); // Converti uint256 in uint32

    uint256 requestId = COORDINATOR.requestRandomWords(
        keyHash,
        subscriptionId64, // Utilizza la conversione esplicita
        requestConfirmations16, // Utilizza la conversione esplicita
        callbackGasLimit32, // Utilizza la conversione esplicita
        numWords32 // Utilizza la conversione esplicita
    );

    emit RequestedRandomness(requestId, tokenId, msg.sender);
    _safeMint(msg.sender, tokenId);
    _setTokenURI(tokenId, tokenURI);
    tokenCounter++;
}

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        uint256 tokenId = tokenCounter - 1;
        tokenIdToRandomNumber[tokenId] = randomWords[0];
        emit MintedNFT(tokenId, randomWords[0]);
    }

    function getTokenRandomNumber(uint256 tokenId) external view returns (uint256) {
        return tokenIdToRandomNumber[tokenId];
    }
}
