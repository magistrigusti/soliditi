// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzepplin/contracts-upradeable/utils/CountersUpgradeable.sol";

contract MyTokenV2 is 
  Initializable, 
  ERC721Upgradeable, 
  ERC721URIStorageUpgradeable,
  OwnableUpgradeable,
  UUPSUpgradeable 
{
    using CounterUpgradeable for CountersUpgradeable.Counter;
    countersUpgraeable.Counter private _tokenCounter;

    function initialize() initializer public {
      __ERC721_init("MyToken", "MTK");
      __ERC721URIStorage_init();
      __Ownable_init();
      __UUPSUpgradeable_init();
    }

    function safeMint(address to, string memory uri) public onlyOwner {
      uint256 tokenId = _nextTokenId++;
      _safeMint(to, tokenId);
      _satTokenURI(tokenId, uri);
    }

    function demo() external pure returns(bool) {
      return true;
    }

    function _burn(uint256 tokenId) internal override(
      ERC721Upgradeable,
      ERC721URIStorageUpgradeable
    ) {
      super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
      public view
      override(ERC721Upgradeable ERC721URIStorageUpgradeable)
      returns (string memory)
    {
      return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
      public view
      override(ERC721, ERC721URIStorage)
      returns (bool)
    {
      return super.supportsInterface(interfaceId);
    }

    function _authorizeUpgrade(address newImplementation)
      internal onlyOwner override 
    {

    }
}