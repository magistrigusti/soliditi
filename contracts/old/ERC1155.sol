// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.22;

// import "./IERC1155.sol";
// import "./IERC1155MetadataURI.sol";
// import "./IERC1155Receiver.sol";

// contract ERC1155 is IERC1155, IERC1155MetadataURI {
//     mapping(uint => mapping(address => uint)) private _balances;
//     mapping(address => mapping(address => bool)) private _operatorApprovals;
//     string private _uri;

//     constructor(string memory uri_) {
//         _setURI(uri_);
//     }

//     function uri(uint id) external view virtual returns (string memory) {
//         return _uri;
//     }

//     function balanceOf(address account, uint id) public view returns (uint) {
//         require(
//             account != address(0),
//             "ERC1155: balance query for the zero address"
//         );
//         return _balances[id][account];
//     }

//     function balanceOfBatch(
//         address[] calldata accounts,
//         uint[] calldata ids
//     ) public view returns (uint[] memory batchBalances) {
//         require(
//             accounts.length == ids.length,
//             "ERC1155: accounts and ids length mismatch"
//         );
//         batchBalances = new uint[](accounts.length);

//         for (uint i = 0; i < accounts.length; ++i) {
//             batchBalances[i] = balanceOf(accounts[i], ids[i]);
//         }
//     }

//     function setApprovalForAll(address operator, bool approved) external {
//         _setApprovalForAll(msg.sender, operator, approved);
//     }

//     function isApprovedForAll(
//         address account,
//         address operator
//     ) public view returns (bool) {
//         return _operatorApprovals[account][operator];
//     }

//     function safeTransferFrom(
//         address from,
//         address to,
//         uint id,
//         uint amount,
//         bytes calldata data
//     ) external {
//         require(
//             from == msg.sender || isApprovedForAll(from, msg.sender),
//             "ERC1155: caller is not owner nor approved"
//         );

//         _safeTransferFrom(from, to, id, amount, data);
//     }

//     function safeBatchTransferFrom(
//         address from,
//         address to,
//         uint[] calldata ids,
//         uint[] calldata amounts,
//         bytes calldata data
//     ) external {
//         require(
//             from == msg.sender || isApprovedForAll(from, msg.sender),
//             "ERC1155: transfer caller is not owner nor approved"
//         );

//         _safeBatchTransferFrom(from, to, ids, amounts, data);
//     }

//     function _safeTransferFrom(
//         address from,
//         address to,
//         uint id,
//         uint amount,
//         bytes calldata data
//     ) internal {
//         require(to != address(0), "ERC1155: transfer to the zero address");

//         address operator = msg.sender;
//         uint[] memory ids = _asSingletonArray(id);
//         uint[] memory amounts = _asSingletonArray(amount);

//         _beforeTokenTransfer(operator, from, to, ids, amounts, data);

//         uint fromBalance = _balances[id][from];
//         require(
//             fromBalance >= amount,
//             "ERC1155: insufficient balance for transfer"
//         );
//         _balances[id][from] = fromBalance - amount;
//         _balances[id][to] += amount;

//         emit TransferSingle(operator, from, to, id, amount);

//         _afterTokenTransfer(operator, from, to, ids, amounts, data);

//         _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
//     }

//     function _safeBatchTransferFrom(
//         address from,
//         address to,
//         uint[] calldata ids,
//         uint[] calldata amounts,
//         bytes calldata data
//     ) internal {
//         require(
//             ids.length == amounts.length,
//             "ERC1155: ids and amounts length mismatch"
//         );

//         address operator = msg.sender;

//         _beforeTokenTransfer(operator, from, to, ids, amounts, data);

//         for (uint i = 0; i < ids.length; ++i) {
//             uint id = ids[i];
//             uint amount = amounts[i];
//             uint fromBalance = _balances[id][from];

//             require(
//                 fromBalance >= amount,
//                 "ERC1155: insufficient balance for transfer"
//             );
//             _balances[id][from] = fromBalance - amount;
//             _balances[id][to] += amount;
//         }

//         emit TransferBatch(operator, from, to, ids, amounts);

//         _afterTokenTransfer(operator, from, to, ids, amounts, data);

//         _doSafeBatchTransferAcceptanceCheck(
//             operator,
//             from,
//             to,
//             ids,
//             amounts,
//             data
//         );
//     }

//     function _setURI(string memory newUri) internal virtual {
//         _uri = newUri;
//     }

//     function _setApprovalForAll(
//         address owner,
//         address operator,
//         bool approved
//     ) internal {
//         require(owner != operator, "ERC1155: setting approval status for self");
//         _operatorApprovals[owner][operator] = approved;
//         emit ApprovelForAll(owner, operator, approved);
//     }

//     function _beforeTokenTransfer(
//         address operator,
//         address from,
//         address to,
//         uint[] memory ids,
//         uint[] memory amounts,
//         bytes memory data
//     ) internal virtual {}

//     function _afterTokenTransfer(
//         address operator,
//         address from,
//         address to,
//         uint[] memory ids,
//         uint[] memory amounts,
//         bytes memory data
//     ) internal virtual {}

//     function _doSafeTransferAcceptanceCheck(
//         address operator,
//         address from,
//         address to,
//         uint id,
//         uint amount,
//         bytes calldata data
//     ) private {
//         if (to.code.length > 0) {
//             try
//                 IERC1155Receiver(to).onERC1155Received(
//                     operator,
//                     from,
//                     id,
//                     amount,
//                     data
//                 )
//             returns (bytes4 response) {
//                 if (response != IERC1155Receiver.onERC1155Received.selector) {
//                     revert("ERC1155: ERC1155Receiver rejected tokens");
//                 }
//             } catch Error(string memory reason) {
//                 revert(reason);
//             } catch {
//                 revert("ERC1155: transfer to non-ERC1155Receiver implementer");
//             }
//         }
//     }

//     function _doSafeBatchTransferAcceptanceCheck(
//         address operator,
//         address from,
//         address to,
//         uint[] memory ids,
//         uint[] memory amounts,
//         bytes calldata data
//     ) private {
//         if (to.code.length > 0) {
//             try
//                 IERC1155Receiver(to).onERC1155BatchReceived(
//                     operator,
//                     from,
//                     ids,
//                     amounts,
//                     data
//                 )
//             returns (bytes4 response) {
//                 if (
//                     response != IERC1155Receiver.onERC1155BatchReceived.selector
//                 ) {
//                     revert("ERC1155: ERC1155Receiver rejected tokens");
//                 }
//             } catch Error(string memory reason) {
//                 revert(reason);
//             } catch {
//                 revert("ERC1155: transfer to non-ERC1155Receiver implementer");
//             }
//         }
//     }

//     function _asSingletonArray(
//         uint element
//     ) private pure returns (uint[] memory) {
//         uint[] memory array = new uint[](1);
//         array[0] = element;
//         return array;
//     }

//     function setAproovalForAll(
//         address operator,
//         bool approved
//     ) external override {}
// }
