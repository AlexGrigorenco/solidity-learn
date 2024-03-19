// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Optimise {

    address public owner;

    constructor(){
        owner = msg.sender;
    }

}

contract UnOptimise {
    
}