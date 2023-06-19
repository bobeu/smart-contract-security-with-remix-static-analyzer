// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Example {
    function sumAsm(uint[] memory data) public pure returns (uint sum) {
        for (uint i = 0; i < data.length; ++i) {
            assembly {
                sum := add(sum, mload(add(add(data, 0x20), mul(i, 0x20))))
            }
        }
    }

    function getBlockHash() public view returns(bytes32 result) {
      result = blockhash(block.number);
    }

    function closeContract(address closeTo) public {
      selfdestruct(payable(closeTo));
    }
}