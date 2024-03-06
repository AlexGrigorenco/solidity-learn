// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Shop {
    address payable public owner;
    mapping (address => uint) public payments;
    uint public contractBalance;

    constructor(){
        owner = payable(msg.sender);
    }

    function payForItem() public payable {
        require(msg.value > 0, "Payment amount must be greater than 0");
        payments[msg.sender] += msg.value;
        updateContractBalance();
    }

    function withdrawAll() public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        owner.transfer(contractBalance);
        updateContractBalance();
    }

    function updateContractBalance() private {
        contractBalance = address(this).balance;
    }
}
