// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract AucEngine {
    address public owner;
    uint constant DURATION = 2 days;
    uint constant FEE = 10;

    struct Auction {
        address payable seller;
        uint startingPrise;
        uint finalPrice;
        uint startAt;
        uint endsAt;
        uint discountRate;
        string item;
        bool stopped;
    }

    Auction[] public auctions;

    event AuctionCreated(uint index, string itemName, uint startingPrice, uint duration);
    event AuctionEnded(uint index, uint finalPrice, address winner);

    constructor(){
        owner = msg.sender;
    }

    function createAuction(uint _startingPrice, uint _discountRate, string calldata _item, uint _duration) external {
        uint duration = _duration != 0 ? _duration : DURATION;

        require(_startingPrice >= _discountRate * duration, "incorrect starting price!");

        Auction memory newAuction = Auction({
            seller: payable(msg.sender),
            startingPrise: _startingPrice,
            finalPrice: _startingPrice,
            discountRate: _discountRate,
            startAt: block.timestamp,
            endsAt: block.timestamp + duration,
            item: _item,
            stopped: false
        });

        auctions.push(newAuction);

        emit AuctionCreated(auctions.length - 1, _item, _startingPrice, duration);
    }

    function getPriceFor(uint index) public view returns(uint) {
        Auction memory cAuction = auctions[index];
        require(!cAuction.stopped, "auction stopped!");
        uint elapsed = block.timestamp - cAuction.startAt;
        uint discount = cAuction.discountRate * elapsed;
        return cAuction.startingPrise - discount;
    }

    function bye(uint index) external payable {
        Auction memory cAuction = auctions[index];
        require(!cAuction.stopped, "auction stopped!");
        require(block.timestamp < cAuction.endsAt, "auction ended!");
        uint cPrice = getPriceFor(index);
        require(msg.value >= cPrice, "not enough founds!");
        cAuction.stopped = true;
        cAuction.finalPrice = cPrice;

        uint refound = msg.value - cPrice;
        if(refound > 0){
            payable(msg.sender).transfer(refound);
        }
        cAuction.seller.transfer(cPrice - ((cPrice * FEE) / 100));
        emit AuctionEnded(index, cPrice, msg.sender);
    }

    function withdraw(address payable _to) external {
        require(msg.sender == owner, "you are not an owner!");
        _to.transfer(address(this).balance);
    }
}