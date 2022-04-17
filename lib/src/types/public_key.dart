import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/blake2b.dart';
import 'package:tuple/tuple.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/types/key_algorithm.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/helpers/json_utils.dart';

class PublicKey {
  /// Byte array of the public key without the key algorithm identifier.
  Uint8List bytes;

  /// The key algorithm used to generate the public key.
  KeyAlgorithm keyAlgorithm;

  factory PublicKey.fromHex(String hex) {
    final Tuple2<Cep57ChecksumResult, Uint8List> decoded = Cep57Checksum.decode(hex.substring(2));

    if (decoded.item1 == Cep57ChecksumResult.invalid) {
      throw ArgumentError('Public key checksum verification failed');
    }

    final Uint8List bytes = decoded.item2;
    KeyAlgorithm algorithm = KeyAlgorithmExt.fromIdentifierByte(hexStringToInt(hex.substring(0, 2)));

    return PublicKey.fromBytes(bytes, algorithm);
  }

  factory PublicKey.fromBytes(Uint8List bytes, KeyAlgorithm algorithm) {
    int expectedPublicKeyLength = algorithm.publicKeyLength;
    if (bytes.length != expectedPublicKeyLength) {
      throw ArgumentError(
          'Public key length is invalid for ${algorithm.name}. Expected $expectedPublicKeyLength bytes, got ${bytes.length}');
    }
    return PublicKey(bytes, algorithm);
  }

  Uint8List get bytesWithIdentifier {
    final Uint8List bytes = Uint8List(this.bytes.length + 1);
    bytes[0] = keyAlgorithm.identifierByte;
    bytes.setAll(1, this.bytes);
    return bytes;
  }

  // TODO: Signature verification

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

  PublicKey(this.bytes, this.keyAlgorithm);
}

class PublicKeyJsonConverter implements JsonConverter<PublicKey, String> {
  const PublicKeyJsonConverter();

  @override
  PublicKey fromJson(String json) {
    return PublicKey.fromHex(json);
  }

  @override
  String toJson(PublicKey object) {
    return object.accountHex;
  }

  factory PublicKeyJsonConverter.create() => PublicKeyJsonConverter();
}

class PublicKeyNullableJsonConverter implements JsonConverter<PublicKey?, String?> {
  const PublicKeyNullableJsonConverter();

  @override
  PublicKey? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return PublicKey.fromHex(json);
  }

  @override
  String? toJson(PublicKey? object) {
    if (object == null) {
      return null;
    }
    return object.accountHex;
  }

  factory PublicKeyNullableJsonConverter.create() => PublicKeyNullableJsonConverter();
}

// @JsonListConverter<PublicKey, String>(PublicKeyJsonConverter.create) annotation
// is unable to generate code. Workaround:
class PublicKeyJsonListConverter extends JsonListConverter<PublicKey> {
  const PublicKeyJsonListConverter() : super(PublicKeyJsonConverter.create);
}
