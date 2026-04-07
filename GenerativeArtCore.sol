// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GenerativeArtCore
 * @dev Stores art scripts and handles deterministic minting.
 */
contract GenerativeArtCore is ERC721, Ownable {
    uint256 public nextTokenId;
    
    struct Project {
        string script; // The p5.js or Three.js code
        uint256 price;
        bool active;
    }

    mapping(uint256 => Project) public projects;
    mapping(uint256 => bytes32) public tokenHashes; // The "DNA" of the NFT

    event ProjectCreated(uint256 indexed projectId, uint256 price);
    event Minted(uint256 indexed tokenId, bytes32 hash);

    constructor() ERC721("Generative Masterpiece", "GEN") Ownable(msg.sender) {}

    function createProject(uint256 _projectId, string calldata _script, uint256 _price) external onlyOwner {
        projects[_projectId] = Project(_script, _price, true);
        emit ProjectCreated(_projectId, _price);
    }

    /**
     * @dev Mints an NFT and generates a unique, permanent hash.
     */
    function mint(uint256 _projectId) external payable {
        Project memory p = projects[_projectId];
        require(p.active, "Project not active");
        require(msg.value >= p.price, "Insufficient payment");

        uint256 tokenId = nextTokenId++;
        bytes32 dna = keccak256(abi.encodePacked(blockhash(block.number - 1), tokenId, msg.sender));
        
        tokenHashes[tokenId] = dna;
        _safeMint(msg.sender, tokenId);

        emit Minted(tokenId, dna);
    }
}
