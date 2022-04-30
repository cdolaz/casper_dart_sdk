import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pointycastle/src/utils.dart' as utils;

Iterable<int> bytesToNibbles(List<int> bytes) {
  // Returns an iterator that yields the nibbles of the given bytes.
  return bytes.expand((element) => [(element >> 4) & 0x0F, element & 0x0F]);
}

// Returns an iterator that yields bits (least significant bits at start) of the given bytes.
Iterable<int> bytesToBits(List<int> bytes) {
  return bytes.expand((element) => [
        element & 0x01,
        (element >> 1) & 0x01,
        (element >> 2) & 0x01,
        (element >> 3) & 0x01,
        (element >> 4) & 0x01,
        (element >> 5) & 0x01,
        (element >> 6) & 0x01,
        (element >> 7) & 0x01
      ]);
}

Uint8List convertToLittleEndian(Uint8List bytes) {
  Uint8List result = Uint8List(bytes.length);
  for (int i = 0; i < bytes.length; ++i) {
    result[i] = bytes[bytes.length - i - 1];
  }
  return result;
}

Uint8List encodeUnsignedBigIntAsLittleEndian(BigInt number) {
  Uint8List bytesAsBigEndian = utils.encodeBigIntAsUnsigned(number);
  return convertToLittleEndian(bytesAsBigEndian);
}

Uint8List encodeUnsignedBigInt(BigInt number) {
  return utils.encodeBigIntAsUnsigned(number);
}

class HexStringBytesJsonConverter implements JsonConverter<Uint8List, String> {
  const HexStringBytesJsonConverter();

  @override
  Uint8List fromJson(String json) {
    return Uint8List.fromList(hex.decode(json));
  }

  @override
  String toJson(Uint8List object) {
    return hex.encode(object);
  }
}

class NullableHexStringBytesJsonConverter implements JsonConverter<Uint8List?, String?> {
  const NullableHexStringBytesJsonConverter();

  @override
  Uint8List? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return Uint8List.fromList(hex.decode(json));
  }

  @override
  String? toJson(Uint8List? object) {
    if (object == null) {
      return null;
    }
    return hex.encode(object);
  }
}
