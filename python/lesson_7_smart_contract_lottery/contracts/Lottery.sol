pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

contract Lottery is Ownable, VRFConsumerBase {
    address payable[] public players;
    AggregatorV3Interface internal ethUsdPriceFeed;
    uint256 public usdEntryFee;
    enum LOTTERY_STATE {
        OPEN,
        CLOSED,
        CALCULATING_WINNER
    }
    LOTTERY_STATE public lottery_state;
    bytes32 public keyHash;
    uint256 public fee;
    address payable public recentWinner;
    uint256 public randomness;

    constructor (address _priceFeedAddress, address _vrfCoordinator, address _link, 
        uint256 _fee, bytes32 _keyhash) public 
        VRFConsumerBase (_vrfCoordinator, _link) {        
        usdEntryFee = 50 * (10**18); // convert to wei
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
        lottery_state = LOTTERY_STATE.CLOSED;
        keyHash = _keyhash;
        fee = _fee;
    }

    function enter() public payable {
        require(lottery_state == LOTTERY_STATE.OPEN);
        require(msg.value >= getEntranceFee(), "Not enought ETH!");
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData(); // price returns *10^8
        uint256 adjustedPrice = uint256(price) * 10**10; // convert to wei 
        uint256 costToEnter = (usdEntryFee * 10**18) / adjustedPrice; 
        return costToEnter;
    }

    function startLottery() public onlyOwner {        
        require(
            lottery_state == LOTTERY_STATE.CLOSED,
            "Can't start a new lottery yet!"
        );
        lottery_state = LOTTERY_STATE.OPEN;
    }

    function endLottery() public {
        lottery_state = LOTTERY_STATE.CALCULATING_WINNER;
        bytes32 requestId = requestRandomness(keyHash, fee);
    }

    /*
        Randomness of chainlink is request/receive architecture.
        Meaning we can consume data from oracle. We need to do 
        2 transactions:
        - By us (we will call) -> requestRandomness -> transaction from generating 
          random number
        - By chainlink (they will call) -> fulfillRandomness -> transaction to send
          generated random number to receiver
    */
    function fulfillRandomness(bytes32 _requestId, uint256 _randomness)
        internal
        override
    {
        require(
            lottery_state == LOTTERY_STATE.CALCULATING_WINNER,
            "You aren't there yet!"
        );
        require(_randomness > 0, "random-not-found");
        uint256 indexOfWinner = _randomness % players.length;
        recentWinner = players[indexOfWinner];
        recentWinner.transfer(address(this).balance);
        // Reset
        players = new address payable[](0);
        lottery_state = LOTTERY_STATE.CLOSED;
        randomness = _randomness;
    }

}