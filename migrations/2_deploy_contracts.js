const StarNotary = artifacts.require("StarNotary");


module.exports = function(deployer) {
  deployer.deploy(StarNotary, "Star Notary Token", "SNT");
  
};