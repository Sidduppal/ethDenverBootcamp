// SPDX-License-Identifier: UNLICENSED

// https://docs.openzeppelin.com/contracts/4.x/erc721
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

import "openzeppelin-contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/utils/Counters.sol";

pragma solidity ^0.8.0;

contract VolcanoNFT is Ownable, ERC721URIStorage {
    // https://ethereum.stackexchange.com/a/116726
    // https://ethereum.stackexchange.com/a/96792
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public balanceMe;

    constructor() ERC721("volcanicRock", "theRock") {}

    function getBalance() public view returns (uint256) {
        return msg.sender.balance;
    }

    // Uri to use: ipfs://bafkreifqs2ujxhjcklnq4lwsic7iqzircmlwlnno7jy2aqjckgxw6ryjeu
    // Image link: ipfs://bafybeiaziiiu4ar3w4idr7m7azs5a2lxmjj76g7qz3frrrywpdisgmzl3i
    // Open sea metadata standards: https://docs.opensea.io/docs/metadata-standards

    function mintNFT(address _user, string memory _uri) public payable {
        require(
            msg.value >= 10000000000000000,
            "The transfer amount must be more than 0.01 ETH."
        );
        payable(owner()).transfer(msg.value);

        uint256 nftID = _tokenIds.current();
        // Increase the counter
        _tokenIds.increment();
        _safeMint(_user, nftID);
        _setTokenURI(nftID, _uri);
    }

    function transferNft(
        address _from,
        address _to,
        uint256 _tokenId
    ) public {
        safeTransferFrom(_from, _to, _tokenId);
    }
}
