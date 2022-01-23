import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Can convert byte array to nibbles', () {
    Uint8List bytes = Uint8List.fromList([0x01, 0xff, 0x35]);

    List<int> nibbles = bytesToNibbles(bytes.toList()).toList();

    expect(nibbles, equals([0x0, 0x1, 0xf, 0xf, 0x3, 0x5]));
  });

  test('Can convert byte array to bits', () {
    Uint8List bytes = Uint8List.fromList([0x01, 0xff, 0x35]);
    List<int> bits = bytesToBits(bytes.toList()).toList();
    expect(
        bits,
        equals([
          0x0,
          0x0,
          0x0,
          0x0,
          0x0,
          0x0,
          0x0,
          0x1,
          0x1,
          0x1,
          0x1,
          0x1,
          0x1,
          0x1,
          0x1,
          0x1,
          0x0,
          0x0,
          0x1,
          0x1,
          0x0,
          0x1,
          0x0,
          0x1
        ]));
  });

  test('Can check if hex string is same case', () {
    expect(true, isHexStringSameCase('0123456789abcdef'));
    expect(true, isHexStringSameCase('0123456789ABCDEF'));
    expect(false, isHexStringSameCase('0123456789abcDeF'));
    expect(true, isHexStringSameCase('abcdef'));
    expect(true, isHexStringSameCase('ABCDEF'));
    expect(false, isHexStringSameCase('abcDeF'));
    expect(() => isHexStringSameCase('abcdefg'), throwsArgumentError);
  });
}
