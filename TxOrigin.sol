// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract TxOrigin {
  uint public depositCounter;
  address payable owner;

  constructor(address payable client) {
    require(client != address(0), "Zero address");
    owner = client;
  }

  function deposit() public payable {
    require(msg.value > 0, "Please send some value");
    depositCounter ++;
  }

  function withdraw(address withdrawTo, uint amount) public {
    require(tx.origin == owner, "Disguised");
    (bool sent,) = withdrawTo.call{value: amount}("");
    require(sent);
  }

}