// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Demo {
    bool public myBool = true; // state

    //unsigned integers
    uint public muInt = 42;
    //uint == uint256 | max = 2**256
    uint8 public mySmallInt = 254;
    //uint8 max = 2**8
    //uint8 0 --> (256 - 1)

    //signed integers
    int public mySignInt = -42;
    int8 public mySignSmallInt = -10;
    //2**7 = 128
    //128 --> (128 - 1)

    constructor (bool _inputBool) {
        bool localBool = false; // local variable

        localBool && _inputBool;
        localBool || _inputBool;
        localBool == _inputBool;
        localBool != _inputBool;
        !localBool;
    }

    function demoInt(uint _inputInt) public  pure  {
        uint _localInt = 84;
        _localInt + _inputInt;
        _localInt + 1;
        _localInt + 1;
        _localInt - 1;
        _localInt * 1;
        _localInt / 1;
        _localInt ** 2;
        _localInt % 2;


        _localInt == _inputInt;
        _localInt != _inputInt;
        _localInt < _inputInt;
        _localInt <= _inputInt;
        _localInt > _inputInt;
        _localInt >= _inputInt;

    }

    function inc() public {
        //mySmallInt = mySignSmallInt + 1;
        //mySmallInt += 1;
        unchecked{
            mySmallInt++;
        }
    }
}