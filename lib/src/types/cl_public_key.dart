import 'dart:convert';
import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/cryptography_utils.dart';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:tuple/tuple.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/types/key_algorithm.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/helpers/json_utils.dart';

class ClPublicKey {
  /// Byte array of the public key without the key algorithm identifier.
  Uint8List bytes;

  /// The key algorithm used to generate the public key.
  KeyAlgorithm keyAlgorithm;

  /// Creates a [ClPublicKey] object from a hexadecimal string representation of bytes.
  /// [hex] includes the key algorithm identifier byte as the first byte.
  factory ClPublicKey.fromHex(String hex) {
    final Tuple2<Cep57ChecksumResult, Uint8List> decoded = Cep57Checksum.decode(hex.substring(2));

    if (decoded.item1 == Cep57ChecksumResult.invalid) {
      throw ArgumentError('Public key checksum verification failed');
    }

    final Uint8List bytes = decoded.item2;
    KeyAlgorithm algorithm = KeyAlgorithmExt.fromIdentifierByte(hexStringToInt(hex.substring(0, 2)));

    return ClPublicKey(bytes, algorithm);
  }

  /// Byte array of the public key, including the key algorithm identifier as the first byte.
  Uint8List get bytesWithKeyAlgorithmIdentifier {
    final Uint8List prefixedBytes = Uint8List(bytes.length + 1);
    prefixedBytes[0] = keyAlgorithm.identifierByte;
    prefixedBytes.setAll(1, bytes);
    return prefixedBytes;
  }

  Future<bool> verify(Uint8List message, Uint8List signatureBytes) async {
    switch (keyAlgorithm) {
      case KeyAlgorithm.ed25519:
        return verifySignatureEd25519(bytes, message, signatureBytes);
      case KeyAlgorithm.secp256k1:
        return verifySignatureSecp256k1(bytes, message, signatureBytes);
    }
  }

  String get accountHex => keyAlgorithm.identifierByteHex + Cep57Checksum.encode(bytes);

  /// Returns prefixed account hash key
  String get accountHash {
    final blake2 = Blake2bDigest(digestSize: 32);
    final algoName = keyAlgorithm.name.toLowerCase();
    final algoNameBytes = Uint8List.fromList(utf8.encode(algoName));
    blake2.update(algoNameBytes, 0, algoNameBytes.length);
    blake2.update(Uint8List.fromList([0]), 0, 1);
    blake2.update(bytes, 0, bytes.length);
    Uint8List hash = Uint8List(32);
    blake2.doFinal(hash, 0);
    return "account-hash-" + Cep57Checksum.encode(hash);
  }

  @override
  String toString() {
    return accountHex;
  }

  /// Creates a [ClPublicKey] object from a byte array and a chosen key algorithm.
  /// [bytes] parameter does not  include the key algorithm identifier byte.
  ClPublicKey(this.bytes, this.keyAlgorithm) {
    int expectedPublicKeyLength = keyAlgorithm.publicKeyLength;
    if (bytes.length != expectedPublicKeyLength) {
      throw ArgumentError(
          'Public key length is invalid for ${keyAlgorithm.name}. Expected $expectedPublicKeyLength bytes, got ${bytes.length}');
    }
  }
}

class ClPublicKeyJsonConverter implements JsonConverter<ClPublicKey, String> {
  const ClPublicKeyJsonConverter();

  @override
  ClPublicKey fromJson(String json) {
    return ClPublicKey.fromHex(json);
  }

  @override
  String toJson(ClPublicKey object) {
    return object.accountHex;
  }

  factory ClPublicKeyJsonConverter.create() => ClPublicKeyJsonConverter();
}

class ClPublicKeyNullableJsonConverter implements JsonConverter<ClPublicKey?, String?> {
  const ClPublicKeyNullableJsonConverter();

  @override
  ClPublicKey? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return ClPublicKey.fromHex(json);
  }

  @override
  String? toJson(ClPublicKey? object) {
    if (object == null) {
      return null;
    }
    return object.accountHex;
  }

  factory ClPublicKeyNullableJsonConverter.create() => ClPublicKeyNullableJsonConverter();
}

// @JsonListConverter<ClPublicKey, String>(ClPublicKeyJsonConverter.create) annotation
// is unable to generate code. Workaround:
class ClPublicKeyJsonListConverter extends JsonListConverter<ClPublicKey> {
  const ClPublicKeyJsonListConverter() : super(ClPublicKeyJsonConverter.create);
}
