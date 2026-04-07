const hre = require("hardhat");

async function main() {
  const ArtCore = await hre.ethers.getContractFactory("GenerativeArtCore");
  const artCore = await ArtCore.deploy();

  await artCore.waitForDeployment();
  console.log("Generative Art Engine deployed to:", await artCore.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
