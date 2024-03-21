// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Optimise {

    // uint public  demo; // gas - 90647

    //uint128 a = 1; // gas - 113298
    //uint128 b = 1;
    //uint256 c = 1;

    // uint a = 1; // gas - 89023

    //bytes32 public hash = 0x9c22ff5f21f0b81b113e63f7db6da94fedef11b2119b4088b89664fb9a3cb658; // gas - 113355

    // mapping (address => uint) payments; // gas - 137967
    // function pay() external payable{// gas - 43394
    //     require(msg.sender != address(0), "zero adres");
    //     payments[msg.sender] = msg.value;
    // }

    // uint[10] payments;
    // function pay() external payable{
    //     require(msg.sender != address(0), "zero adres");
    //     payments[0] = msg.value;
    // }

    // uint8[] demo = [1,2,3];

    // uint c = 1;
    // uint d;

    // function calc() public  {
    //     uint a = c + 1;
    //     uint b = 2 * c;
    //     d = a + b;
    // }

    uint public result = 1;
    function setResult(uint[] memory data) public  {
        uint temp = result;
        for (uint i = 0; i < data.length; i++){
            temp *= data[i];
        }
        result = temp;
    }

}

contract UnOptimise {
    // uint public  demo = 0; // gas - 92904

    //uint128 a = 1; // gas - 135148
    //uint256 c = 1;
    //uint128 b = 1;

    // uint8 a = 1;  // gas - 89426

    //bytes32 public hash = keccak256( // gas - 114995
    //    abi.encodePacked("test")
    //);

    // mapping (address => uint) payments;  // gas - 139047
    // function pay() external payable{// gas - 43407
    //     address _from = msg.sender;
    //     require(_from != address(0), "zero adres");
    //     payments[_from] = msg.value;
    // }

    // uint[] payments; 
    // function pay() external payable{
    //     require(msg.sender != address(0), "zero adres");
    //     payments.push(msg.value);
    // }

    // uint[] demo = [1,2,3];

    // uint c = 1;
    // uint d;

    // function calc() public  {
    //     uint a = c + 1;
    //     uint b = 2 * c;
    //     summ(a, b);
    // }

    // function summ(uint a, uint b) private {
    //     d = a + b;
    // }

    uint public result = 1;
    function setResult(uint[] memory data) public  {
        for (uint i = 0; i < data.length; i++){
            result *= data[i];
        }
    }
}