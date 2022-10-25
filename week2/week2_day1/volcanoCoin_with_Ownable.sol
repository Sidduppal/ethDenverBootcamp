// SPDX-License-Identifier: UNLICENSED
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

contract VolcanoCoin is Ownable{
    uint256 coinSupply = 10000;

    constructor() {

        // Option 1
        balances[owner()] = coinSupply;
        // Option 2
        // address _owner = owner();
        // balances[_owner] = coinSupply;
        
    }

    event supplyChange(uint256 newTotalSupply);
    event updateTransfer(uint256 amount, address recepeint);
    // error NotEnoughFunds(uint256 requested, uint256 available);

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
        // if (_amount > balances[msg.sender] ) {
        //     revert NotEnoughFunds(_amount, balances[msg.sender]);
        // }
        require(balances[msg.sender] >= _amount, "The transfer amount must be more than the account balance." );
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_recipientAddr] = balances[_recipientAddr] + _amount;
        emit updateTransfer(_amount, _recipientAddr);
        paymentRecords[msg.sender].push(
            Payment({transferAmount: _amount, recipientAddr: _recipientAddr})
        );
    }
}
