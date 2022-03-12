const Campaign = require("../artifacts/contracts/Campaign.sol/CampaignFactory.json");

module.exports = function (deployer) {
  deployer.deploy(Campaign);
};
