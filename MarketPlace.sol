pragma solidity >=0.4.0 <0.6.0;

contract MarketPlace {

    address payable public owner;
    string public item;
    address public highestBidder;
    bool public active = false;
    
    mapping (address => uint) public bids;

constructor(string memory _item) public {
    owner = msg.sender;
    item = _item;
} 

function start() public {
    require(owner == msg.sender); 
    active = true;
}

function bid() public payable {
    require(bids[msg.sender] == 0);
    require(active);
    require(highestBidder == address(0) || msg.value > bids[highestBidder]);
    highestBidder = msg.sender;
    bids[highestBidder] = msg.value;
}

function acceptBid() public {
    require(active);
    require(msg.sender == owner);
    active = false;
    uint amount = bids[highestBidder];
    bids[highestBidder] = 0;
    owner.transfer(amount);
}

function withdraw() public {
    require(!active);
    require(bids[msg.sender] > 0);
    uint amount = bids[msg.sender];
    bids[highestBidder] = 0;
    msg.sender.transfer(amount);
}


}
