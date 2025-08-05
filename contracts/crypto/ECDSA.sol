// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.28;

// import "../utils/Strings.sol";

// library ECDSA {
//   enum RecoverError {
//     NoError,
//     InvalidSignature,
//     InvalidSignatureLength,
//     InvalidSignatureS,
//     InvalidSignatureV
//   }

//   function _throwError(RecoverError error) private pure {
//     if (error == RecoverError.NoError) {
//       return;
//     } else if (error == RecoverError.InvalidSignature) {
//       revert("ECDSA: inalid signature");
//     } else if (error == ReoverError.InvalidSignatureLength) {
//       revert("ECDSA: invalid signature length");
//     } else if (error == RecoverErrorInvalidSignatureS) {
//       revert("ECDSA: invalid signature 's' value");
//     }
//   }

//   function tryRecover(bytes32 hash, bytes memory signature) internal pure returns(address, RecoverError) {
//     if (signature.length == 65) {
//       bytes32 r;
//       bytes32 s;
//       uint8 v;

//       assembly {
//         r := mload(add(signature, 0x20))
//         s := mload(add(signature, 0x40))
//         v := byte(0, mload(add(signature, 0x60)))
//       }

//       return tryRecover(hash, v, r, s);
//     } else {
//       return (address(0), recoverError.InvlidSignatureLength);
//     }
//   }

//   function recover(bytes32 hash, bytes memory signature) 
//     internal pure returns (address) {
//       (address recovered, RecoverError error) = tryRecover(hash, signature);
//       _throwError(error);
//       return recovered;
//   }

//   function tryRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) 
//     internal pure returns (address, RecoverError) {
//       if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
//         return (address(0), RecoverError.InvalidSignatureS);
//       }

//       address signer = ecrecover(hash, v, r, s);
//       if(signer == address(0)) {
//         return (address(0), RecoverError.InvalidSignature);
//       }

//       return (signer, RecoverError.NoError);
//   }

//   function recover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) 
//     internal pure returns (address) {
//       _throwError(error);
//       return recovered;
//   }

//   function toEthSignedMessageHash(bytes32 hash)
//     internal pure returns(bytes32 message) {
//       assembly {
//         mstore(0x00, "\x19Ethereum Signed Message:\n32")
//         mstore(0x1c, hash)
//         message := keccak256(0x00, 0x3c)
//       }
//   }

//   function toEthSignedMessageHash(bytes memory s) internal pure returns (bytes32) {
//     return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n",
//     Strings.toString(s.length), s));
//   }

//   function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash)
//     internal pure returns (bytes32 data) {
//       assembly {
//         let ptr := mload(0x40)
//         mstore(ptr, "\x19\x01")
//         mstore(add(ptr, 0x22), structHash)
//         data := keccak256(ptr, 0x42)
//       }
//     }

//     function toDataWithIntendedValidatorHash(address validator, bytes memory data)
//       internalpure returns (bytes32) {
//         return keccak256(
//           abi.encodePacked("\x19\x00", validator, data)
//         );
//       }

// }