# On-chain Generative Art (Art Blocks-style)

A professional-grade implementation for decentralized creative coding. This repository solves the "Centralized Metadata" problem. Instead of an NFT pointing to a JPEG on a server, the *logic* to create the art is stored on the blockchain. When a collector mints a token, the contract provides a unique hash that acts as a "DNA" string, feeding into the stored script to render a one-of-a-kind masterpiece in the browser.

## Core Features
* **Script Storage:** Compresses and stores JavaScript-based art engines (p5.js) directly on-chain or via linked permanent storage.
* **Deterministic Randomness:** Uses the `blockhash` and `tokenId` to create a permanent seed for every mint.
* **Project Shells:** Multi-project support allowing different artists to launch unique collections through a single factory.
* **Flat Architecture:** Single-directory layout for the Art Factory, Script Registry, and Minting Logic.



## Logic Flow
1. **Upload:** Artist uploads a p5.js script to the contract (e.g., "Draw 100 circles with random colors").
2. **Mint:** Collector pays 0.1 ETH. The contract assigns a unique `hash` (DNA) to that `tokenId`.
3. **Render:** The frontend pulls the script and the DNA. The script uses the DNA to decide the exact colors and positions.
4. **Permanent:** Because the script and DNA are on-chain, the art can be reconstructed 100 years from now without any external servers.

## Setup
1. `npm install`
2. Deploy `GenerativeArtFactory.sol`.
