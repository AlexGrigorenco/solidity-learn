// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

//Merkle tree

contract Tree {
    //      H-root
    //   H1-2    H3-4
    //  H1  H2  H3  H4
    // TX1 TX2 TX3 TX4

    bytes32[] public hashes;
    string[4] transactions = [
        "TX1: Sherlock -> John",
        "TX2: John -> Sherlock",
        "TX3: John -> Mary", 
        "TX4: Mary -> Sherlock"
    ];

    constructor() {
        for (uint256 i = 0; i < transactions.length; i++) {
            hashes.push(makeHash(transactions[i]));
        }

        uint256 count = transactions.length;
        uint256 offset = 0;

        while (count > 0) {
            for (uint256 i = 0; i < count - 1; i += 2) {
                hashes.push(
                    keccak256(
                        abi.encodePacked(
                            hashes[offset + i],
                            hashes[offset + i + 1]
                        )
                    )
                );
            }
            offset += count;
            count = count / 2;
        }
    }

    function verify(string memory transaction, uint index, bytes32 root, bytes32[] memory proof) public pure returns (bool) {

        bytes32 hash = makeHash(transaction);

        for(uint i = 0; i < proof.length; i++){
            bytes32 el = proof[i];
            if(index % 2 == 0){
                hash = keccak256(abi.encodePacked(hash, el));
            } else {
                hash = keccak256(abi.encodePacked(el, hash));
            }
            index = index/2;
        }

        return hash == root;
    }

    function encode(string memory input) public pure returns (bytes memory) {
        return abi.encodePacked(input);
    }

    function makeHash(string memory input) public pure returns (bytes32) {
        return keccak256(encode(input));
    }
}
