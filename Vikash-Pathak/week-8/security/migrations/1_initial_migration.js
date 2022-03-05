const AccessControl = artifacts.require("AccessControl");

module.exports = async function (deployer) {
  await deployer.deploy(AccessControl, 111);
};
