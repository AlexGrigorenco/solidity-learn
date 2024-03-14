// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Demo {

    // Struct 

    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping (uint => Payment) payments;
    }

    mapping (address => Balance) public balances;

    function structPay(string memory message) public payable {
        uint paymentNumber = balances[msg.sender].totalPayments++;

        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNumber] = newPayment;
    }

    function getPayments(address _addr, uint _num) public view returns (Payment memory){
        return balances[_addr].payments[_num];
    }

    //Byte

    bytes32 public staticLengthVar = "hello world";
    bytes public dynamicLengthVar = "hello world";
    bytes public dynamicLengthVarRu = unicode"привет мир!";

    //1-->32
    //32*8 = 256

    function getLength(uint256 value) public view returns (uint256) {
        if (value == 0) {
            return staticLengthVar.length;
        }
        if (value == 1) {
            return dynamicLengthVar.length;
        }
        if (value == 2) {
            return dynamicLengthVarRu.length;
        }

        return 404;
    }

    function getElementByIndex(uint256 value) public view returns (bytes1) {
        return staticLengthVar[value];
    }

    //Array

    uint256[3][2] public myArray;

    uint256[] public dynamicLengthArray;
    uint256 public arrayLength;

    function fillDynamicLengthArray() public {
        dynamicLengthArray.push(42);
        dynamicLengthArray.push(84);
        arrayLength = dynamicLengthArray.length;
    }

    function sampleArrayInMemory() public pure returns (uint256[] memory) {
        uint256[] memory tempArray = new uint256[](10);
        tempArray[0] = 1;
        tempArray[1] = 2;
        tempArray[2] = 3;

        return tempArray;
    }

    function fillArray() public {
        myArray = [[1, 2, 3], [4, 5, 6]];
    }

    // Enum

    enum Status {
        Paid,
        Delivered,
        Received
    }

    Status public currenStatus;

    function pay() public {
        currenStatus = Status.Paid;
    }

    function delivered() public {
        currenStatus = Status.Delivered;
    }

    function received() public {
        currenStatus = Status.Received;
    }
}
