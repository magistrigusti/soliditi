// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "./IERC721Metadata.sol";
import "./IERC721Receiver.sol";
import "./ERC165.sol";
import "./Strings.sol";

// contract ERC721 is ERC165, IERC721Metadata {
//   using Strings for uint;
//   string public name;
//   string public symbol;
//   mapping(address => uint) _balances;
//   mapping(uint => address) _owners;
//   mapping(uint => address) _tokenApprovals;
//   mapping(address => mapping(address => bool)) _operatorApprovals;

//   modifier _requireMinted(uint tokenId) {
//     require(_exists(tokenId), "not minted");
//     _;
//   }

//   constructor(string memory _name, string memory _symbol) {
//     name = _name;
//     symbol = _symbol;
//   }

//   function balanceOf(address owner) public view returns(uint) {
//     require(owner != address(0), "zero address");
//     return _balances[owner];
//   }

//   // function transferFrom(address from, address to, uint tokenId) external {
//   //   require(_isApprovedOrOwner(msg.sender, tokenId), "not an owner or approved!");
//   //   _transfer(from, to, tokenId);
//   // }

//   // function safeTransferFrom(address from, address to, uint tokenId) public {
//   //   require(_isApprovedOrOwner(msg.sender, tokenId), "not an owner or approved!");
//   //   _safeTransfer(from, to, tokenId);
//   // }

//   function _baseURI() internal pure virtual returns(string memory) {
//     return "";
//   }

//   function tokenURI(uint tokenId) 
//   public view virtual _requireMinted(tokenId) returns(string memory) {
//     string memory baseURI = _baseURI();  
//     return bytes(baseURI).length > 0 ?
//       string(abi.encodePacked(baseURI, tokenId.toString())) :
//       "";
//   }

//   // function approve(address to, uint tokenId) public {
//   //   address _owner = ownerOf(tokenId);
//   //   require(_owner == msg.sender || isApprovedForAll(_owner, msg.sender), "not an owner");
//   //   require(to != _owner, "cannot approve to self");

//   //   _tokenApprovals[tokenId] = to;


//   //   emit Approval(_owner, to, tokenId);
//   // }

//   // function ownerOf(uint tokeId) public view _requireMinted(tokenId) returns(address) {
//   //   return _owners[tokenId];
//   // }

//   // function supportsInterface(bytes4 interfaceId) external view returns(bool) {
//   //   return interfaceId == type(IERC721).interfaceId ||
//   //     super.supportsInterface(interfaceId);
//   // }

//   function _isApprovedForAll(address owner, address operator) 
//     public view returns(bool) {
//     return _operatorApprovals[owner][operator];
//   }

//   // function getApproved(uint tokenId) 
//   //   public view _requireMinted returns(address) {
//   //   return _tokenApprovals[tokenId];
//   // }

//   // function burn(uint tokenId) public virtual {
//   //   require(_isApprovedOeOwner(msg.sender, tokenId), "not an owner!");
//   //   address owner = ownerOf (tokenId);

//   //   delete _tokenApprovals[tokenId];
//   //   _balances[owner]--;
//   //   delete _owners[tokenId];
//   // }

//   // function _saveMint(address to, uint tokenId) internal virtual {
//   //     _mint(to, tokenId);

//   //     require(_checkOnERC721Received(msg.sender, to, tokenId), "non erc721 receiver!");
//   // }

//   function _mint(address to, uint tokenId) internal virtual {
//     require(to != address(0), "to cannot be zero");
//     require(!_exists(tokenId), "already exists");
    
//     _owners[tokenId] = to;
//     _balances[to]++;
//   }

//   // function _safeTransfer(address from, address to, uint tokenId) internal {
//   //   _transfer(from, to, tokenId);
//   //   require(_checkOnErc721Received(from, to, tokenId), "non erc721 receiver!");
//   // }

//   function _checkOnErc721Received(address from, address to, uint tokenId)
//   private returns(bool) {
//     if (to.code.length > 0) {
//       try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, bytes("")
//       ) returns(bytes4 ret) {
//         return ret == IERC721Receiver.onERC721Received.selector;
//       } catch(bytes memory reason) {
//         if(reason.length == 0) {
//           revert("Non erc721 receiver!");
//         } else {
//           assembly {
//             revert(add(32, reason), mload(reason))
//           }
//         }
//       }
//     } else {
//       return true;
//     }
//   }

//   // function _transfer(address from, address to, uint tokenId) internal {
//   //   require(ownerOf(tokenId) == from, "not an owner!" );
//   //   require(to != address(0), "to cannot be zero!");

//   //   _beforeTransferToken(from, to, tokenId);

//   //   _balances[from]--;
//   //   _balances[to]++;
//   //   _owner[tokenId] = to;

//   //   emit Transfer(from, to, tokenId);

//   //   _afterTokenTransfer(from, to, tokenId);
//   // }

//   function _beforeTokenTransfer(address from, address to, uint tokenId) internal virtual {}
//   function _afterTokenTransfer(address from, address to, uint tokenId) internal virtual {}

//   // function _isApprovedOrOwner(address spender, uint tokenId) internal view returns(bool) {
//   //   address owner = ownerOf(tokenId);

//   //   require(
//   //     spender == owner ||
//   //     isApprovedForAll(owner, spender) ||
//   //     getApproved(tokenId) == spender,
//   //     "not an owner or approved!"
//   //   );
//   // }

//   function _exists(uint tokenId) internal view returns(bool) {
//     return _owners[tokenId] != address(0);
//   }

// }