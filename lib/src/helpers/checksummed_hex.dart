import 'dart:typed_data';
import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:casper_dart_sdk/src/helpers/lang_utils.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/dart.dart';
import 'package:tuple/tuple.dart';

enum Cep57ChecksumResult {
  noChecksum,
  valid,
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

    final DartBlake2b blake2b = DartBlake2b();
    final blake2bSink = blake2b.newHashSink();
    blake2bSink.add(bytes);
    blake2bSink.close();
    final hashBits = bytesToBits(blake2bSink.hashSync().bytes).toList();

    final inputNibbles = bytesToNibbles(bytes);
    var buffer = StringBuffer();
    int bitIndex = 0;
    for (var element in inputNibbles) {
      final c = hexChars[element].codeUnitAt(0);
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
