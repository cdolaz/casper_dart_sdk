import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:tuple/tuple.dart';

import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';

enum Cep57ChecksumResult {
  /// For backward compatibility: If the hex string is not small in size or
  /// is not mixed case, no checksum is calculated.
  noChecksum,

  /// The computed checksum is valid.
  valid,

  /// The computed checksum does not match the checksum in the hex string.
  invalid,
}

/// See CEP-57: https://github.com/xcthulhu/ceps/blob/checksummed-addresses/text/0057-checksummed-addresses.md
class Cep57Checksum {
  Cep57Checksum._();
  static const smallBytesCount = 75;
  static const hexChars = '0123456789abcdef';
  static Tuple2<Cep57ChecksumResult, Uint8List> decode(String hexString) {
    // Decode base16
    final bytes = Uint8List.fromList(hex.decode(hexString));

    // Backward compatibility: If the hex string is not small in size or is not mixed case, do not verify the checksum.
    if (bytes.length > smallBytesCount || isHexStringSameCase(hexString)) {
      return Tuple2(Cep57ChecksumResult.noChecksum, bytes);
    }

    // Verify checksum
    final recomputed = Cep57Checksum.encode(bytes);

    final result = recomputed == hexString
        ? Cep57ChecksumResult.valid
        : Cep57ChecksumResult.invalid;

    return Tuple2(result, bytes);
  }

  static String encode(Uint8List bytes) {
    if (bytes.length > smallBytesCount) {
      return hex.encode(bytes.toList());
    }

    final blake2 = Blake2bDigest(digestSize: 32);
    final blake2Hashed = blake2.process(bytes);
    final hashBits = bytesToBits(blake2Hashed).toList();

    final inputNibbles = bytesToNibbles(bytes);
    var buffer = StringBuffer();
    int bitIndex = 0;
    for (var nibble in inputNibbles) {
      final c = hexChars[nibble].codeUnitAt(0);
      if ((c >= 'a'.codeUnitAt(0) && c <= 'f'.codeUnitAt(0)) &&
          hashBits[bitIndex++ % hashBits.length] != 0) {
        final upperC = c - 'a'.codeUnitAt(0) + 'A'.codeUnitAt(0);
        buffer.write(String.fromCharCode(upperC));
      } else {
        buffer.write(String.fromCharCode(c));
      }
    }

    return buffer.toString();
  }
}

class Cep57ChecksummedHexJsonConverter extends JsonConverter<String, String> {
  const Cep57ChecksummedHexJsonConverter();

  @override
  String fromJson(String json) {
    final hexString = json;
    final Tuple2<Cep57ChecksumResult, Uint8List> decoded =
        Cep57Checksum.decode(hexString);
    if (decoded.item1 == Cep57ChecksumResult.invalid) {
      throw ArgumentError('Invalid CEP-57 checksum');
    }
    return json;
  }

  @override
  String toJson(String object) {
    return object;
  }
}

class HexBytesWithCep57ChecksumConverter implements JsonConverter<Uint8List, String> {
  const HexBytesWithCep57ChecksumConverter();

  @override
  Uint8List fromJson(String json) {
    final result = Cep57Checksum.decode(json);
    if (result.item1 == Cep57ChecksumResult.invalid) {
      throw ArgumentError('Invalid checksum in hex string: $json');
    }
    return result.item2;
  }

  @override
  String toJson(Uint8List object) {
    return Cep57Checksum.encode(object);
  }
}
