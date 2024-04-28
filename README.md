# CrowdFunding Smart Contract

## Description
This Ethereum smart contract facilitates crowdfunding operations, allowing users to contribute funds towards a set goal within a specified time period. Contributors can vote on fund usage requests and, if the crowdfunding fails, claim refunds. The owner can create spending requests and execute payments upon successful votes.

## Features
- **Contribute Funds**: Users can contribute to the crowdfunding campaign if they are not the owner and the campaign is active.
- **Refund**: Contributors can request a refund if the crowdfunding campaign fails to meet its goal after the specified period.
- **Request Management**: The owner can create requests for fund allocation which contributors can vote on.
- **Voting System**: Contributors can vote on whether a fund allocation request should be approved.
- **Execute Payments**: If a request has a majority vote, the owner can execute the payment to the specified receiver.

## Contract Details
- **Network**: Ethereum Mainnet/Testnets (as deployed)
- **Compiler Version**: Solidity ^0.8
- **SPDX-License-Identifier**: MIT

## Prerequisites
- [Node.js](https://nodejs.org/) and npm
- [Truffle Suite](https://www.trufflesuite.com/) (optional for deployment and testing)
- [MetaMask](https://metamask.io/) (or any other Ethereum wallet for interaction optional if want to deploy on testnet)
