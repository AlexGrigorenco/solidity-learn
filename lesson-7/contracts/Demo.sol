// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Demo {
    //require
    //revert
    //assert  - Panic

    address owner;

    constructor(){
        owner = msg.sender;
    }

    receive() external payable{
        pay();
    }

    event Paid(address _from, uint _amount, uint _timestamp);

    function pay() public payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }



    function withdraw(address payable _to) external {
        require(msg.sender == owner, "you are not an owner");
        _to.transfer(address(this).balance);
    }

    function withdrawRevert(address payable _to) external {
        if(msg.sender != owner){
            revert("you are not an owner");
        } else {
            _to.transfer(address(this).balance);
        }
    }


    modifier onlyOwner (address _to) {
        require(msg.sender == owner, "you are not an owner");
        require(_to != address(0), "incorrect address");
        _;
        //возможны дополнительные проверки...
    }

    function withdrawModifier(address payable _to) external onlyOwner(_to){
        _to.transfer(address(this).balance);
    }
}