// SPDX-License-Identifier: UNLICENSED

// https://docs.openzeppelin.com/contracts/4.x/erc721
// import "openzeppelin-contracts/token/ERC721/ERC721.sol";
// import "openzeppelin-contracts/utils/Counters.sol";

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/utils/Counters.sol";

/**
 * @title VolcanoCoin
 * @author @Sidduppal
 */

pragma solidity ^0.8.0;

contract VolcanoNFT is ERC721 {
    // https://ethereum.stackexchange.com/a/116726
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("volcanicRock", "theRock") {}

    function mintNFT(address _user) public {
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
}
