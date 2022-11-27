// SPDX-License-Identifier: UNLICENSED
import "openzeppelin-contracts/access/Ownable.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

contract VolcanoCoin is Ownable {
    uint256 coinSupply = 10000;

    constructor() {
        balances[owner()] = coinSupply;
    }

    event supplyChange(uint256 newTotalSupply);
    event updateTransfer(uint256 amount, address recepeint);

    mapping(address => uint256) public balances;

    struct Payment {
        uint256 transferAmount;
        address recipientAddr;
    }

    mapping(address => Payment[]) public paymentRecords;

    function getTotalSupply() public view returns (uint256) {
        return coinSupply;
    }

    function updateSupply() public onlyOwner {
        coinSupply = coinSupply + 1000;
        emit supplyChange(coinSupply);
    }

    function transfer(uint256 _amount, address _recipientAddr) public {
        require(
            balances[msg.sender] >= _amount,
            "The transfer amount must be more than the account balance."
        );
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_recipientAddr] = balances[_recipientAddr] + _amount;
        recordPayment(msg.sender, _recipientAddr, _amount);
        emit updateTransfer(_amount, _recipientAddr);
    }

    function viewPaymentRecords(address _user)
        public
        view
        returns (Payment[] memory)
    {
        return paymentRecords[_user];
    }

    function recordPayment(
        address _senderAddr,
        address _receiverAddr,
        uint256 _amount
    ) public {
        paymentRecords[_senderAddr].push(
            Payment({transferAmount: _amount, recipientAddr: _receiverAddr})
        );
    }
}
