import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tuple/tuple.dart';
import 'package:convert/convert.dart';

void main() {
  group("Byte utils", () {
    test("can convert byte array to nibbles", () {
      Uint8List bytes = Uint8List.fromList([0x01, 0xff, 0x35]);

      List<int> nibbles = bytesToNibbles(bytes.toList()).toList();

      expect(nibbles, equals([0x0, 0x1, 0xf, 0xf, 0x3, 0x5]));
    });

    test("can convert byte array to bits", () {
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
  });

  group("String utils", () {
    test("can check if hex string is same case", () {
      expect(true, isHexStringSameCase('0123456789abcdef'));
      expect(true, isHexStringSameCase('0123456789ABCDEF'));
      expect(false, isHexStringSameCase('0123456789abcDeF'));
      expect(true, isHexStringSameCase('abcdef'));
      expect(true, isHexStringSameCase('ABCDEF'));
      expect(false, isHexStringSameCase('abcDeF'));
      expect(() => isHexStringSameCase('abcdefg'), throwsArgumentError);
    });

    test("can shorten human readable duration", () {
      String input1 = '52secs';
      String input2 = '52sec';

      String result1 = input1.replaceAll(RegExp(r'sec(s)?', caseSensitive: false), 's');
      String result2 = input2.replaceAll(RegExp(r'sec(s)?', caseSensitive: false), 's');
      String result3 = input1.replaceAll(RegExp(r'min(s)?', caseSensitive: false), 'm');

      expect(result1, equals('52s'));
      expect(result2, equals('52s'));
      expect(result3, equals('52secs'));

      var r = HumanReadableDurationJsonConverter.shorten('53secs', "sec", "s");
      expect(r, equals('53s'));
    });

    test("can convert human readable duration to Duration object", () {
      String humanReadableDuration = '1hours 30m';
      Duration duration = HumanReadableDurationJsonConverter().fromJson(humanReadableDuration);
      expect(duration.inMinutes, 90);
    });

    test("can convert Duration object to human readable duration", () {
      Duration duration = Duration(minutes: 90);
      String humanReadableDuration = HumanReadableDurationJsonConverter().toJson(duration);
      expect(humanReadableDuration, '1h 30m');
    });

    test("can capitalize first letter", () {
      String input = 'abcdef';
      String result = capitalizeFirstLetter(input);
      expect(result, equals('Abcdef'));
    });
  });

  group("Casper Dart SDK", () {
    group("CEP-57", () {
      test("can encode checksummed string", () {
        final String result = Cep57Checksum.encode(Uint8List.fromList(hex.decode("0123456789abcdef")));
        expect(false, isHexStringSameCase(result));
      });
    });
  });
}
