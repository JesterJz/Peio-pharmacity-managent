const Auth = artifacts.require("Auth");
const CaleroMain = artifacts.require("CaleroMain");
const Ownable = artifacts.require("Ownable");

module.exports = function (deployer) {
  deployer.deploy(Auth);
  deployer.deploy(CaleroMain);
  deployer.deploy(Ownable);
};
