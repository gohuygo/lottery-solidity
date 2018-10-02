pragma solidity ^0.4.17;

contract Lottery {
  address public manager;
  address[] public players;

  constructor() public {
    manager = msg.sender;
  }

  function enter() public payable {
    require(msg.value > .01 ether);
    players.push(msg.sender);
  }

  function pickWinner() public onlyManager {
    uint index = generateRandomNumber() % players.length;
    players[index].transfer(address(this).balance);
    players = new address[](0);
  }

  function generateRandomNumber() private view returns (uint) {
    return uint(keccak256(block.difficulty, now, players));
  }

  modifier onlyManager() {
    require(msg.sender == manager);
    _;
  }

  function getPlayers() public view returns (address[]) {
    return players;
  }
}
