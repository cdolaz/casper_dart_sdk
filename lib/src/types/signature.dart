import 'dart:typed_data';

import 'package:tuple/tuple.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/types/key_algorithm.dart';

/// Cryptographic signature of a data.
class Signature {
  /// Byte array of the signature without the key algorithm identifier.
  Uint8List headlessBytes;

  /// The key algorithm used to generate the signature.
  KeyAlgorithm keyAlgorithm;

  /// Creates a [Signature] object from a hexadecimal string representation.
  /// The hexadecimal string is prefixed with [keyAlgorithm.identifierByteHex].
  factory Signature.fromHex(String hexStr) {
    final Tuple2<Cep57ChecksumResult, Uint8List> decoded = Cep57Checksum.decode(hexStr.substring(2));

    if (decoded.item1 == Cep57ChecksumResult.invalid) {
      throw ArgumentError('Signature checksum verification failed');
    }

    final Uint8List bytes = decoded.item2;
    KeyAlgorithm algorithm = KeyAlgorithmExt.fromIdentifierByte(hexStringToInt(hexStr.substring(0, 2)));

    return Signature.fromBytes(bytes, algorithm);
  }

  /// Creates a Signature object from a byte array and a key algorithm.
  factory Signature.fromBytes(Uint8List signature, KeyAlgorithm algorithm) {
    return Signature(signature, algorithm);
  }

  /// Creates a Signature object from a byte array that includes the
  /// key algorithm identifier byte as the first byte.
  factory Signature.fromBytesWithAlgorithmIdentifier(Uint8List bytes) {
    KeyAlgorithm algorithm = KeyAlgorithmExt.fromIdentifierByte(bytes[0]);
    return Signature.fromBytes(bytes.sublist(1), algorithm);
  }

  /// Returns a byte array that includes the key algorithm identifier byte as the first byte.
  Uint8List get bytes {
    // Set signature algorithm identifier
    final buffer = Uint8List(headlessBytes.lengthInBytes + 1);
    buffer[0] = keyAlgorithm.value;
    // Copy signature bytes
    buffer.setRange(1, buffer.length, headlessBytes);
    return buffer;
  }

  /// Returns a hexadecimal string representation of the signature that includes
  /// the key algorithm identifier byte as the first two chars.
  String toHex() {
    return keyAlgorithm.identifierByteHex + Cep57Checksum.encode(headlessBytes);
  }

  @override
  String toString() {
    return toHex();
  }

  Signature(this.headlessBytes, this.keyAlgorithm);
}

class SignatureJsonConverter extends JsonConverter<Signature, String> {
  const SignatureJsonConverter();

  @override
  Signature fromJson(String json) {
    return Signature.fromHex(json);
  }

  @override
  String toJson(Signature object) {
    return object.toHex();
  }
}
