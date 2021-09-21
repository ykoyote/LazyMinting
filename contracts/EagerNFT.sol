//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract EagerNFT is ERC721URIStorage, AccessControl {

    using Counters for Counters.Counter;
    Counters.Counter _tokenIds;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address minter)
        ERC721("EagerNFT", "EGR") {
            _setupRole(MINTER_ROLE, minter);
        }

    function mint(address buyer, string memory tokenURI) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Unauthorized");

        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _mint(buyer, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return ERC721.supportsInterface(interfaceId) || AccessControl.supportsInterface(interfaceId);
    }

}