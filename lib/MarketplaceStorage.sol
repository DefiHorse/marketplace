// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MarketplaceStorage {
    IERC20 public acceptedToken;

    struct Order {
        // Order ID
        bytes32 id;
        // Owner of the NFT
        address seller;
        // NFT registry address
        address nftAddress;
        // Price (in wei) for the published item
        uint256 price;
        // Time when this sale ends
        uint256 expiresAt;
    }

    // From ERC721 registry assetId to Order (to avoid asset collision)
    mapping (address => mapping(uint256 => Order)) public orderByAssetId;

    uint256 public publicationFeeInWei;

    bytes4 public constant InterfaceId_ValidateFingerprint = bytes4(
        keccak256("verifyFingerprint(uint256,bytes)")
    );

    bytes4 public constant ERC721_Interface = bytes4(0x80ac58cd);

    // EVENTS
    event OrderCreated(
        bytes32 id,
        uint256 indexed assetId,
        address indexed seller,
        address nftAddress,
        uint256 priceInWei,
        uint256 expiresAt
    );
    event OrderSuccessful(
        bytes32 id,
        uint256 indexed assetId,
        address indexed seller,
        address nftAddress,
        uint256 totalPrice,
        address indexed buyer
    );
    event OrderCancelled(
        bytes32 id,
        uint256 indexed assetId,
        address indexed seller,
        address nftAddress
    );

}
