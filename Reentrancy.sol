// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Reentrancy {

  struct Balances {
    uint value;
    uint depositTime;
  }

  mapping(address =>Balances) private savings;

  constructor() { }

  function deposit() public payable {
    uint amount = msg.value;
    require(amount > 0, "Please send some value");
    savings[msg.sender] = Balances(amount, _now());
  }

  function _now() internal view returns(uint) {
    return block.timestamp;
  }

  function withdraw(address withdrawTo, uint amount) public {
    require(savings[msg.sender].value > amount, "Disguised");
    require(_now() + 86400 > savings[msg.sender].depositTime, "Only after 24 hours");
    (bool sent,) = withdrawTo.call{value: amount}("");
    require(sent);
    savings[msg.sender].value -= amount;
  }

}