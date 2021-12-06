var TodoList = artifacts.require("./TodoList.sol");
var BombiToken = artifacts.require("./BombiToken.sol");

module.exports = function (deployer) {
  deployer.deploy(TodoList);
  deployer.deploy(BombiToken, 21000000);
};
