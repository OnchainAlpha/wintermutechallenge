// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";

contract VulnerableVault is ERC4626 {
    constructor(IERC20 asset_) ERC4626(asset_) ERC20("Vulnerable Vault", "vVLT") {}

    // Intentionally vulnerable to donation attacks by using default ERC4626 implementation
} 