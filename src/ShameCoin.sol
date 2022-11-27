// SPDX-License-Identifier: UNLICENSED
import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.0;

/**
 * @title ShameCoin contract
 * @notice Contract to send ShameCoin.
 * @author Siddharth Uppal - <sidd.uppal96@gmail.com>
 */

contract ShameCoin is ERC20, Ownable {
    address public admin;

    constructor(uint256 _initialSupply) ERC20("ShameCoin", "SHM") {
        admin = owner();
        _mint(admin, _initialSupply);
    }

    /**
     * @notice Mint shamecoin tokens.
     * @param to Recepient's address.
     * @param amount The amount to transfer.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /// @notice Set the decimal value to 0.
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    /**
     * @notice Transfer ShameCoin. ShameCoin can only be transferred by the admin, if
     * a non-admin tries to transfer ShameCoin his balance is increased by one.
     * @param to Recepient's address.
     * @param amount The amount to transfer. Should be equal to one.
     */
    function transfer(address to, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        require(amount == 1, "You can only transfer 1 ShameCoin at a time!!");
        if (msg.sender == admin) {
            require(
                balanceOf(msg.sender) >= 1,
                "Atleast one ShameCoin is needed."
            );
            _transfer(admin, to, amount);
            return true;
        } else {
            _transfer(admin, msg.sender, amount);
            return false;
        }
    }

    /**
     * @notice Give admin the permission to transfer ShameCoin on the user's behalf.
     * @param spender Recepient's address.
     * @param amount The amount to transfer. Should be equal to one.
     */
    function approve(address spender, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        require(amount == 1, "You can only transfer 1 ShameCoin at a time!!");
        require(
            spender == admin,
            "Only the admin can be approved as the spender."
        );
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }
}
