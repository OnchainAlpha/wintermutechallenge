const hre = require("hardhat");

async function main() {
    // Deploy TestToken
    const TestToken = await hre.ethers.getContractFactory("TestToken");
    const testToken = await TestToken.deploy();
    await testToken.deployed();
    console.log("TestToken deployed to:", testToken.address);

    // Deploy VulnerableVault
    const VulnerableVault = await hre.ethers.getContractFactory("VulnerableVault");
    const vault = await VulnerableVault.deploy(testToken.address);
    await vault.deployed();
    console.log("VulnerableVault deployed to:", vault.address);

    // We'll deploy these later if needed
    // const VulnerabilityChecker = await hre.ethers.getContractFactory("VulnerabilityChecker");
    // const checker = await VulnerabilityChecker.deploy();
    // await checker.deployed();
    // console.log("VulnerabilityChecker deployed to:", checker.address);

    // const FrontrunningBot = await hre.ethers.getContractFactory("FrontrunningBot");
    // const bot = await FrontrunningBot.deploy();
    // await bot.deployed();
    // console.log("FrontrunningBot deployed to:", bot.address);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
}); 