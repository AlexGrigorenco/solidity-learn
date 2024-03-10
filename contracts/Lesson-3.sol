// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Demo {
    address payable public owner;
    mapping (address => uint) public payments;
    uint public contractBalance;

    address myAddres = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    string public myStr = "qwerty";

    function getAddresBalance(address value) public view returns (uint256) {
        address _from = value;
        return _from.balance;
    }

    function transferTo(address value, uint amount) public {
        address payable _to = payable (value);
        _to.transfer(amount);
    }

    function payForItem() public payable {
        require(msg.value > 0, "Payment amount must be greater than 0");
        payments[msg.sender] += msg.value;
        updateContractBalance();
    }
    function updateContractBalance() private {
        contractBalance = address(this).balance;
    }

    function demoStr(string memory myNewValue) public {
        string memory myTempStr = "qwerty qwerty";
        myStr = myTempStr;
        myStr = "qwerty qwerty qwerty";
        myStr = myNewValue;
    }
}
