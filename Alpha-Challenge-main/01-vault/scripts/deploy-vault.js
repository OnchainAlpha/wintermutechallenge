const hre = require("hardhat");

async function main() {
    // Use the already deployed TestToken address
    const testTokenAddress = "0x9673fA02C4cfA629c3e7515a8029cbAD06AA0197";
    
    // Deploy VulnerableVault
    const VulnerableVault = await hre.ethers.getContractFactory("VulnerableVault");
    const vault = await VulnerableVault.deploy(testTokenAddress);
    await vault.deployed();
    console.log("VulnerableVault deployed to:", vault.address);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
}); 