// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Optimise {

    // uint public  demo; // gas - 90647

    //uint128 a = 1; // gas - 113298
    //uint128 b = 1;
    //uint256 c = 1;

    // uint a = 1; // gas - 89023

    bytes32 public hash = 0x9c22ff5f21f0b81b113e63f7db6da94fedef11b2119b4088b89664fb9a3cb658; // gas - 113355

}

contract UnOptimise {
    // uint public  demo = 0; // gas - 92904

    //uint128 a = 1; // gas - 135148
    //uint256 c = 1;
    //uint128 b = 1;

    // uint8 a = 1;  // gas - 89426

    bytes32 public hash = keccak256( // gas - 114995
        abi.encodePacked("test")
    );
}