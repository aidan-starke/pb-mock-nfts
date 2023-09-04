// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721, Ownable {
    uint256 public currentTokenId;
    string public tokenUriBase;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mintTo(address recipient) public returns (uint256) {
        uint256 newItemId = currentTokenId++;
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        return string(abi.encodePacked(tokenUriBase, Strings.toString(tokenId)));
    }

    function setTokenURI(string memory _tokenUriBase) public onlyOwner {
        tokenUriBase = _tokenUriBase;
    }
}
