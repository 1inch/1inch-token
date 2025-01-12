<div align="center">
    <img src="https://1inch.exchange/assets/images/logo.svg" alt="1inch Logo">
</div>

# 1inch Token

## Introduction

This repository contains the smart contract code for the 1inch token, a utility token used within the 1inch network. The repository includes Solidity contracts and JavaScript tools for testing and project management.

## Features

- **Smart Contracts**: Solidity contracts for the 1inch token.
- **JavaScript Tools**: Tools for testing, documentation, and project management.
- **Optimizations**: Various utilities and optimizations to improve contract efficiency.

## Installation

### NPM

```bash
npm install 1inch-token
yarn add 1inch-token
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@1inch/1inch-token/contracts/1inchToken.sol";

contract Example {
    1inchToken public token;

    constructor(address _tokenAddress) {
        token = 1inchToken(_tokenAddress);
    }

    function transferTokens(address recipient, uint256 amount) public {
        token.transfer(recipient, amount);
    }
}
