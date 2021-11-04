// SPDX-Licence-Identifier: MIT

pragma solidity >=0.6.2 <0.9.0;

// GET THE LATEST PRICE
// - downlad contract: https://docs.chain.link/docs/get-the-latest-price/
// - get faucet of konan
// - deploy above Smart Contract to Konan network

// google: npm @chainlink/contracts
// github: https://github.com/smartcontractkit/chainlink
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 


contract FundMe {
    
    mapping(address => uint256) public addressToAmountFunded;
    
    // payable - this function can be used to pay for things
    // value - every transaction has a value
    // sender - sender address
    function fund() public payable {
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    function getVersion() public view returns (uint256) {
        // zober interface AggregatorV3Interface z chainlinku
        // a napln jeho metody implementaciou na 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        // addresses of implementation: https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        // store result of latestRoundData to a tuple
        (,int256 answer,,,) = priceFeed.latestRoundData();
        // solidity doesnt have decimal points, so the correct answer is
        // answer / 100000000
        return uint256(answer); 
    }
}