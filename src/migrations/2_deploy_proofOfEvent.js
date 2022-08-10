const ProofOfEvent = artifacts.require("./ProofOfEvent.sol");

module.exports = function (deployer) {
  deployer.deploy(ProofOfEvent);
};
