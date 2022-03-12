// const Campaign = artifacts.require("Campaign");

const { artifacts } = require("hardhat");

// const OpenFund = require('../artifacts/contracts/OpenFund.sol/OpenFunds.json');
const { Migration } = require('../artifacts/contracts/Migration.sol/Migrations.json');
const { OpenFunds } = require('../artifacts/contracts/OpenFund.sol/OpenFunds.json');

module.exports = function (deployer) {
  deployer.deploy(Migration);
  deployer.deploy(OpenFunds);
};

