// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract fundingPortal {//FundMe
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public pointingAddressTofund;  //addressToAmountFunded
    address[] public funders;//funders
    address public addressOfOwner;
    AggregatorV3Interface public addOfFunder;
    
    constructor(address _addOfFunder) public {
        addOfFunder = AggregatorV3Interface(_addOfFunder);
        addressOfOwner = msg.sender;
    }

    function fund() public payable {
        uint256 minimumUSD = 50 * 10**18;
        require(
            ConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );
        pointingAddressTofund[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return addOfFunder.version();
    }

    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = addOfFunder.latestRoundData();
        return uint256(answer * 10000000000);
    }

    // 1000000000
    function ConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    function EntranceFee() public view returns (uint256) {
        // minimumUSD
        uint256 minimumUSD = 50 * 10**18;
        uint256 price = getPrice();
        uint256 precision = 1 * 10**18;
        // return (minimumUSD * precision) / price;
        // We fixed a rounding error found in the video by adding one!
        return ((minimumUSD * precision) / price) + 1;
    }

    modifier onlyOwner() {
        require(msg.sender == addressOfOwner);
        _;
    }

    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);

        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            pointingAddressTofund[funder] = 0;
        }
        funders = new address[](0);
    }
}