// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.22;

// import "./ERC721.sol";
// import "./IERC721Enumerable.sol";
// import "./ERC721URIStorage.sol";

// contract MyToken is ERC721URIStorage {
//   address public owner;
//   uint currentTokenId;

//   constructor() ERC721("MyToken", "MTK") {
//     owner = msg.sender;
//   }

//   function safeMint(address to, string calldata tokenId) public {
//     require(owner == msg.sender, "not an owner!");

//     _safeMint(to, currentTokenId);
//     _setTokenURI(currentTokenId, tokenId);

//     currentTokenId++;
//   }

//   function supportsInterface(bytes4 interfaceId)
//     public view 
//     override(ERC721, ERC721Enumerable)
//     returns (bool) 
//   {
//     return super.supportsInterface(interfaceId);
//   }

//   function _baseURI() internal pure override returns(string memory) {
//     return "ipfs://";
//   }

//   function _burn(uint tokenId) internal override(ERC721, ERC721URIStorage) {
//     super._burn(toknId);
//   }

//   function tokenURI(
//     uint tokenId
//   ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
//     return super.tokenURI(tokenId);
//   }

//   function _beforeTokenTransfer(address from, address to, uint tokenId)
//   internal override(ERC721, ERC721Enumerable)
//   {
//     super._beforeTokenTransfer(from, to, tokenId);
//   }
// }