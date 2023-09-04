// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract SFT is ERC1155 {
    constructor(string memory _uri) ERC1155(_uri) {}

    function mint(address recipient, uint256 tokenId, uint256 quantity) public {
        _mint(recipient, tokenId, quantity, "");
    }
}
