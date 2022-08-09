const AvnToken = artifacts.require("./AvnToken.sol");

module.exports = function (deployer) {
  deployer.deploy(AvnToken);
};
