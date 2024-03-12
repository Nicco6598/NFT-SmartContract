// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol';
import '@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol';

contract MyNFT is VRFConsumerBaseV2, ERC721URIStorage, Ownable {
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;
    uint32 private constant NUMBER_OF_METADATA = 3;
    mapping(uint256 => address) public s_requestIdToSender;
    uint256 public s_tokenCounter;
    uint256 internal i_mintFee;

    error RandomIpfsNft_InsufficientETHSent();
    error RandomIpfsNft_TransferFailed();

    event NftRequestedWithNewIdFromVRF(uint256 requestId, address senderAddress);
    event NFTMinted(uint256 newTokenID, address nftOwner);

    constructor(
        address vrfCoordinatorV2,
        uint64 subscriptionId,
        bytes32 gasLane,
        uint32 callbackGasLimit,
        uint256 mintFee
    )
        VRFConsumerBaseV2(vrfCoordinatorV2)
        ERC721('Random On Chain NFT', 'RR')
        Ownable(msg.sender)
    {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        i_mintFee = mintFee;
    }

    function requestNft() public payable returns (uint256 requestId) {
        if (msg.value < i_mintFee) {
            revert RandomIpfsNft_InsufficientETHSent();
        }
        requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        s_requestIdToSender[requestId] = msg.sender;
        emit NftRequestedWithNewIdFromVRF(requestId, msg.sender);
        return requestId;
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {
        address nftOwner = s_requestIdToSender[requestId];
        uint256 newTokenID = s_tokenCounter;
        uint256 moddedIndex = randomWords[0] % NUMBER_OF_METADATA;
        string memory tokenURI = string(abi.encodePacked("ipfs://MyNFTYoga/", uintToString(moddedIndex)));
        _safeMint(nftOwner, newTokenID);
        _setTokenURI(newTokenID, tokenURI);
        emit NFTMinted(newTokenID, nftOwner);
        s_tokenCounter++;
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        (bool success, ) = payable(msg.sender).call{value: amount}('');
        if (!success) {
            revert RandomIpfsNft_TransferFailed();
        }
    }

    function getMintFee() public view returns (uint256) {
        return i_mintFee;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function uintToString(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;
        while (_i != 0) {
            bstr[k--] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}
