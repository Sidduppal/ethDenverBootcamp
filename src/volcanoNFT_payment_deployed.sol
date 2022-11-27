// SPDX-License-Identifier: UNLICENSED
// This contract has been deploted at 0x25A646E20904A6C363017516EfC4e80A2f3Bdf3D

// https://docs.openzeppelin.com/contracts/4.x/erc721
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/utils/Counters.sol";
import "openzeppelin-contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

contract VolcanoNFT is ERC721, Ownable {
    // https://ethereum.stackexchange.com/a/116726
    // https://ethereum.stackexchange.com/a/96792
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public balanceMe;

    constructor() ERC721("volcanicRock", "theRock") {}

    function getBalance() public view returns (uint256) {
        return msg.sender.balance;
    }

    function mintNFT(address _user) public payable {
        // https://ethereum.stackexchange.com/a/91418
        // Taking ETH as payment
        // In this case i have to put the amount value to donate into VALUE textbox found in DEPLOY section
        require(
            msg.value >= 1000000000000000,
            "The transfer amount must be more than 0.01 ETH."
        );
        payable(owner()).transfer(msg.value);

        uint256 nftID = _tokenIds.current();
        // Increase the counter
        _tokenIds.increment();
        _safeMint(_user, nftID);
    }

    function transferNft(
        address _from,
        address _to,
        uint256 _tokenId
    ) public {
        safeTransferFrom(_from, _to, _tokenId);
    }

    // https://ethereum.stackexchange.com/a/136049
    function _baseURI() internal pure override returns (string memory) {
        return "myBaseUrl";
    }
}
