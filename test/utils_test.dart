import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

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
            0x1,
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
            0x1,
            0x0,
            0x1,
            0x1,
            0x0,
            0x0
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
      void testCep57Encoder(String hash) {
        final result = Cep57Checksum.decode(hash);
        final checksumResult = result.item1;
        final bytes = result.item2;
        expect(checksumResult, equals(Cep57ChecksumResult.valid));
        expect(hash, equals(Cep57Checksum.encode(bytes)));
      }
      test("can encode checksummed string", () {
        testCep57Encoder("eA1D6C19ccAeb35Ae717065c250E0F7F6Dc64AC3c6494a797E0b33A23CA1f1b9");
        testCep57Encoder("98d945f5324F865243B7c02C0417AB6eaC361c5c56602FD42ced834a1Ba201B6");
        testCep57Encoder("8cf5E4aCF51f54Eb59291599187838Dc3BC234089c46fc6cA8AD17e762aE4401");
      });
    });
  });
}
