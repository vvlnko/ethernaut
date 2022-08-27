// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console.sol";

// import '@openzeppelin/contracts/math/SafeMath.sol';

contract Reentrance {
  
  // using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to] + msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      require(result, "tx failed");
    //   if(result) {
    //     _amount;
    //   }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}