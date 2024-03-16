// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Demo {
    //public
    //external
    //internal
    //private

    string message = 'hello world!';

    //view
    //pure

    uint public balance;

    fallback() external payable { }

    receive() external payable { }

    function pay() external payable {
        balance += msg.value;
    }


    //transaction
    function setMsg(string memory newMsg) external {
        message = newMsg;
    }

    function getBalance( ) public view returns (uint balance){
        balance = address(this).balance;
        //return balance;
    }

    function getMesg() external view returns (string memory) {
        return message;
    }

    function rate(uint input) internal pure returns (uint) {
        return input * 3;
    }
}