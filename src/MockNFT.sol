// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MockNFT
 * @notice Simple ERC721 for testing the staking protocol
 * @dev Anyone can mint for testing purposes
 */
contract MockNFT is ERC721, Ownable {
    uint256 private _nextTokenId;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC721(name_, symbol_) Ownable(msg.sender) {}

    /**
     * @notice Mint a new NFT to the specified address
     * @param to Recipient address
     * @return tokenId The ID of the minted token
     */
    function mint(address to) external returns (uint256 tokenId) {
        tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    /**
     * @notice Batch mint multiple NFTs to an address
     * @param to Recipient address
     * @param amount Number of tokens to mint
     * @return startId The first token ID minted
     */
    function batchMint(address to, uint256 amount) external returns (uint256 startId) {
        startId = _nextTokenId;
        for (uint256 i = 0; i < amount; i++) {
            _safeMint(to, _nextTokenId++);
        }
    }
}

