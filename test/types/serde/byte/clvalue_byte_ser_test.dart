import 'dart:typed_data';

import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group("ClValue byte serialization", () {
    // Some tests are adapted from Casper .NET SDK.
    group("ClValue.bool", () {
      test("ClValue.bool(false) serializes to '010000000000'", () {
        final boolValue = ClValue.bool(false);
        final bytes = boolValue.toBytes();
        expect(hex.encode(bytes), "010000000000");
      });

      test("ClValue.bool(true) serializes to '010000000100'", () {
        final boolValue = ClValue.bool(true);
        final bytes = boolValue.toBytes();
        expect(hex.encode(bytes), "010000000100");
      });

      test("ClValue.option(ClValue.bool(false)) serializes to '0200000001000d00'", () {
        final optionBoolValue = ClValue.option(ClValue.bool(false));
        final bytes = optionBoolValue.toBytes();
        expect(hex.encode(bytes), "0200000001000d00");
      });

      test("ClValue.option(ClValue.bool(true)) serializes to '0200000001010d00'", () {
        final optionBoolValue = ClValue.option(ClValue.bool(true));
        final bytes = optionBoolValue.toBytes();
        expect(hex.encode(bytes), "0200000001010d00");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.bool)) serializes to '01000000000d00'", () {
        final optionBoolValue = ClValue.optionNone(ClTypeDescriptor(ClType.bool));
        final bytes = optionBoolValue.toBytes();
        expect(hex.encode(bytes), "01000000000d00");
      });
    });

    group("ClValue.i32", () {
      test("ClValue.i32(-10) serializes to '04000000f6ffffff01'", () {
        final int32Value = ClValue.i32(-10);
        final bytes = int32Value.toBytes();
        expect(hex.encode(bytes), "04000000f6ffffff01");
      });

      test("ClValue.option(ClValue.i32(-10)) serializes to '0500000001f6ffffff0d01'", () {
        final optionInt32Value = ClValue.option(ClValue.i32(-10));
        final bytes = optionInt32Value.toBytes();
        expect(hex.encode(bytes), "0500000001f6ffffff0d01");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.i32)) serializes to '01000000000d01'", () {
        final optionInt32Value = ClValue.optionNone(ClTypeDescriptor(ClType.i32));
        final bytes = optionInt32Value.toBytes();
        expect(hex.encode(bytes), "01000000000d01");
      });
    });

    group("ClValue.i64", () {
      test("ClValue.i64(-16) serializes to '08000000f0ffffffffffffff02'", () {
        final int64Value = ClValue.i64(-16);
        final bytes = int64Value.toBytes();
        expect(hex.encode(bytes), "08000000f0ffffffffffffff02");
      });

      test("ClValue.option(ClValue.i64(-16)) serializes to '0900000001f0ffffffffffffff0d02'", () {
        final optionInt64Value = ClValue.option(ClValue.i64(-16));
        final bytes = optionInt64Value.toBytes();
        expect(hex.encode(bytes), "0900000001f0ffffffffffffff0d02");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.i64)) serializes to '01000000000d02'", () {
        final optionInt64Value = ClValue.optionNone(ClTypeDescriptor(ClType.i64));
        final bytes = optionInt64Value.toBytes();
        expect(hex.encode(bytes), "01000000000d02");
      });
    });

    group("ClValue.u8", () {
      test("ClValue.u8(0x00) serializes to '010000000003'", () {
        final u8Value = ClValue.u8(0x00);
        final bytes = u8Value.toBytes();
        expect(hex.encode(bytes), "010000000003");
      });

      test("ClValue.u8(0x7f) serializes to '010000007f03'", () {
        final u8Value = ClValue.u8(0x7f);
        final bytes = u8Value.toBytes();
        expect(hex.encode(bytes), "010000007f03");
      });

      test("ClValue.option(ClValue.u8(0xff)) serializes to '0200000001ff0d03'", () {
        final optionU8Value = ClValue.option(ClValue.u8(0xff));
        final bytes = optionU8Value.toBytes();
        expect(hex.encode(bytes), "0200000001ff0d03");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.u8)) serializes to '01000000000d03'", () {
        final optionU8Value = ClValue.optionNone(ClTypeDescriptor(ClType.u8));
        final bytes = optionU8Value.toBytes();
        expect(hex.encode(bytes), "01000000000d03");
      });
    });

    group("ClValue.u32", () {
      test("ClValue.u32(0xffffffff) serializes to '04000000ffffffff04'", () {
        final u32Value = ClValue.u32(0xffffffff);
        final bytes = u32Value.toBytes();
        expect(hex.encode(bytes), "04000000ffffffff04");
      });

      test("ClValue.option(ClValue.u32(0x0)) serializes to '0500000001000000000d04'", () {
        final optionU32Value = ClValue.option(ClValue.u32(0x0));
        final bytes = optionU32Value.toBytes();
        expect(hex.encode(bytes), "0500000001000000000d04");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.u32)) serializes to '01000000000d04'", () {
        final optionU32Value = ClValue.optionNone(ClTypeDescriptor(ClType.u32));
        final bytes = optionU32Value.toBytes();
        expect(hex.encode(bytes), "01000000000d04");
      });
    });

    group("ClValue.u64", () {
      test("ClValue.u64(0xffffffffffffffff) serializes to '08000000ffffffffffffffff05'", () {
        final u64Value = ClValue.u64(0xffffffffffffffff);
        final bytes = u64Value.toBytes();
        expect(hex.encode(bytes), "08000000ffffffffffffffff05");
      });

      test("ClValue.option(ClValue.u64(1)) serializes to '090000000101000000000000000d05'", () {
        final optionU64Value = ClValue.option(ClValue.u64(1));
        final bytes = optionU64Value.toBytes();
        expect(hex.encode(bytes), "090000000101000000000000000d05");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.u64)) serializes to '01000000000d05'", () {
        final optionU64Value = ClValue.optionNone(ClTypeDescriptor(ClType.u64));
        final bytes = optionU64Value.toBytes();
        expect(hex.encode(bytes), "01000000000d05");
      });
    });

    group("ClValue.u128", () {
      test("ClValue.u128(0xffffffffffffffff) serializes to '0900000008ffffffffffffffff06'", () {
        final u128Value = ClValue.u128(BigInt.parse('ffffffffffffffff', radix: 16));
        final bytes = u128Value.toBytes();
        expect(hex.encode(bytes), "0900000008ffffffffffffffff06");
      });

      test("ClValue.option(ClValue.u128(U128.max-1)) serializes to '120000000110feffffffffffffffffffffffffffffff0d06'",
          () {
        var num = BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16);
        num -= BigInt.one;
        expect(num.bitLength, 128);
        final optionU128Value = ClValue.option(ClValue.u128(num));
        final bytes = optionU128Value.toBytes();
        expect(hex.encode(bytes), "120000000110feffffffffffffffffffffffffffffff0d06");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.u128)) serializes to '01000000000d06'", () {
        final optionU128Value = ClValue.optionNone(ClTypeDescriptor(ClType.u128));
        final bytes = optionU128Value.toBytes();
        expect(hex.encode(bytes), "01000000000d06");
      });
    });

    group("ClValue.u256", () {
      test("ClValue.u256(0xffffffffffffffff) serializes to '0900000008ffffffffffffffff07'", () {
        final u256Value = ClValue.u256(BigInt.parse('ffffffffffffffff', radix: 16));
        final bytes = u256Value.toBytes();
        expect(hex.encode(bytes), "0900000008ffffffffffffffff07");
      });

      test(
          "ClValue.option(ClValue.u256(U256.max-0x80)) serializes to "
          "'2200000001207fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0d07'", () {
        var num = BigInt.parse('ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', radix: 16);
        num -= BigInt.parse("80", radix: 16);
        expect(num.bitLength, 256);
        final optionU256Value = ClValue.option(ClValue.u256(num));
        final bytes = optionU256Value.toBytes();
        expect(hex.encode(bytes), "2200000001207fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0d07");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.u256)) serializes to '01000000000d07'", () {
        final optionU256Value = ClValue.optionNone(ClTypeDescriptor(ClType.u256));
        final bytes = optionU256Value.toBytes();
        expect(hex.encode(bytes), "01000000000d07");
      });
    });

    group("ClValue.u512", () {
      test("ClValue.u512(0xffffffffffffffff) serializes to '0900000008ffffffffffffffff08'", () {
        final u512Value = ClValue.u512(BigInt.parse('ffffffffffffffff', radix: 16));
        final bytes = u512Value.toBytes();
        expect(hex.encode(bytes), "0900000008ffffffffffffffff08");
      });

      test(
          "ClValue.option(ClValue.u512(U512.max-0x80)) serializes to "
          "'230000000120fffffffffffffffffffffffffffffffffffffffffffff"
          "fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0d08'", () {
        var num = BigInt.parse('f' * 128, radix: 16);
        num -= BigInt.parse("80", radix: 16);
        expect(num.bitLength, 512);
        final optionU512Value = ClValue.option(ClValue.u512(num));
        final bytes = optionU512Value.toBytes();
        expect(
            hex.encode(bytes),
            "4200000001407fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
            "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0d08");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.u512)) serializes to '01000000000d08'", () {
        final optionU512Value = ClValue.optionNone(ClTypeDescriptor(ClType.u512));
        final bytes = optionU512Value.toBytes();
        expect(hex.encode(bytes), "01000000000d08");
      });
    });

    group("ClValue.unit", () {
      test("ClValue.unit() serializes to '0000000009'", () {
        final unitValue = ClValue.unit();
        final bytes = unitValue.toBytes();
        expect(hex.encode(bytes), "0000000009");
      });

      test("ClValue.option(ClValue.unit()) serializes to '01000000010d09'", () {
        final optionUnitValue = ClValue.option(ClValue.unit());
        final bytes = optionUnitValue.toBytes();
        expect(hex.encode(bytes), "01000000010d09");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.unit)) serializes to '01000000000d09'", () {
        final optionUnitValue = ClValue.optionNone(ClTypeDescriptor(ClType.unit));
        final bytes = optionUnitValue.toBytes();
        expect(hex.encode(bytes), "01000000000d09");
      });
    });

    group("ClValue.string", () {
      test("ClValue.string('Hello, Casper!') serializes to '120000000e00000048656c6c6f2c20436173706572210a'", () {
        final stringValue = ClValue.string("Hello, Casper!");
        final bytes = stringValue.toBytes();
        expect(hex.encode(bytes), "120000000e00000048656c6c6f2c20436173706572210a");
      });

      test(
          "ClValue.option(ClValue.string('Hello, Casper!')) serializes to '13000000010e00000048656c6c6f2c20436173706572210d0a'",
          () {
        final optionStringValue = ClValue.option(ClValue.string("Hello, Casper!"));
        final bytes = optionStringValue.toBytes();
        expect(hex.encode(bytes), "13000000010e00000048656c6c6f2c20436173706572210d0a");
      });

      test("ClValue.option(ClValue.string('')) serializes to '0500000001000000000d0a'", () {
        final optionStringValue = ClValue.option(ClValue.string(""));
        final bytes = optionStringValue.toBytes();
        expect(hex.encode(bytes), "0500000001000000000d0a");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.string)) serializes to '01000000000d0a'", () {
        final optionStringValue = ClValue.optionNone(ClTypeDescriptor(ClType.string));
        final bytes = optionStringValue.toBytes();
        expect(hex.encode(bytes), "01000000000d0a");
      });
    });

    group("ClValue.key", () {
      final accountHashKey = AccountHashKey("989ca079a5e446071866331468ab949483162588d57ec13ba6bb051f1e15f8b7");
      test("A sample ClValue.key(AccountHashKey) correctly serializes to bytes", () {
        final accountHashValue = ClValue.key(accountHashKey);
        final bytes = accountHashValue.toBytes();
        expect(hex.encode(bytes), "2100000000989ca079a5e446071866331468ab949483162588d57ec13ba6bb051f1e15f8b70b");
      });

      test("Sample ClValue.option(ClValue.key(AccountHashKey) correctly serializes to bytes", () {
        final optionAccountHashValue = ClValue.option(ClValue.key(accountHashKey));
        final bytes = optionAccountHashValue.toBytes();
        expect(hex.encode(bytes), "220000000100989ca079a5e446071866331468ab949483162588d57ec13ba6bb051f1e15f8b70d0b");
      });

      test("Sample ClValue.optionNone(ClTypeDescriptor(ClType.key)) correctly serializes to bytes", () {
        final optionAccountHashValue = ClValue.optionNone(ClTypeDescriptor(ClType.key));
        final bytes = optionAccountHashValue.toBytes();
        expect(hex.encode(bytes), "01000000000d0b");
      });
    });

    group("ClValue.uref", () {
      final uref = Uref("000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f-007");
      test("A sample ClValue.uref correctly serializes to bytes", () {
        final urefValue = ClValue.uref(uref);
        final bytes = urefValue.toBytes();
        expect(hex.encode(bytes), "21000000000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f070c");
      });

      test("Sample ClValue.option(ClValue.uref) correctly serializes to bytes", () {
        final optionUrefValue = ClValue.option(ClValue.uref(uref));
        final bytes = optionUrefValue.toBytes();
        expect(hex.encode(bytes), "2200000001000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f070d0c");
      });

      test("Sample ClValue.optionNone(ClTypeDescriptor(ClType.uref)) correctly serializes to bytes", () {
        final optionUrefValue = ClValue.optionNone(ClTypeDescriptor(ClType.uref));
        final bytes = optionUrefValue.toBytes();
        expect(hex.encode(bytes), "01000000000d0c");
      });
    });

    group("ClValue.publicKey", () {
      final publicKey = PublicKey.fromHex("01381b36cd07Ad85348607ffE0fA3A2d033eA941D14763358eBEacE9C8aD3cB771");
      test("A sample ClValue.publicKey correctly serializes to bytes", () {
        final publicKeyValue = ClValue.publicKey(publicKey);
        final bytes = publicKeyValue.toBytes();
        expect(hex.encode(bytes), "2100000001381b36cd07ad85348607ffe0fa3a2d033ea941d14763358ebeace9c8ad3cb77116");
      });

      test("Sample ClValue.option(ClValue.publicKey) correctly serializes to bytes", () {
        final optionPublicKeyValue = ClValue.option(ClValue.publicKey(publicKey));
        final bytes = optionPublicKeyValue.toBytes();
        expect(hex.encode(bytes), "220000000101381b36cd07ad85348607ffe0fa3a2d033ea941d14763358ebeace9c8ad3cb7710d16");
      });

      test("Sample ClValue.optionNone(ClTypeDescriptor(ClType.publicKey)) correctly serializes to bytes", () {
        final optionPublicKeyValue = ClValue.optionNone(ClTypeDescriptor(ClType.publicKey));
        final bytes = optionPublicKeyValue.toBytes();
        expect(hex.encode(bytes), "01000000000d16");
      });
    });

    group("ClValue.list", () {
      final list = [ClValue.u32(1), ClValue.u32(2), ClValue.u32(3), ClValue.u32(4)];
      test("A sample ClValue.u32 list correctly serializes to bytes", () {
        final listValue = ClValue.list(list);
        final bytes = listValue.toBytes();
        expect(hex.encode(bytes), "1400000004000000010000000200000003000000040000000e04");
      });

      test("Sample ClValue.option(ClValue.list) correctly serializes to bytes", () {
        final optionListValue = ClValue.option(ClValue.list(list));
        final bytes = optionListValue.toBytes();
        expect(hex.encode(bytes), "150000000104000000010000000200000003000000040000000d0e04");
      });

      test("Sample ClValue.optionNone(ClTypeDescriptor(ClType.list)) correctly serializes to bytes", () {
        final optionListValue = ClValue.optionNone(ClListTypeDescriptor(ClTypeDescriptor(ClType.u32)));
        final bytes = optionListValue.toBytes();
        expect(hex.encode(bytes), "01000000000d0e04");
      });

      test("An empty ClValue.list(ClType.key) correctly serializes to bytes", () {
        final listValue = ClValue.emptyList(ClTypeDescriptor(ClType.key));
        final bytes = listValue.toBytes();
        expect(hex.encode(bytes), "04000000000000000e0b");
      });
    });

    group("ClValue.byteArray", () {
      final byteArray = hex.decode("0102030405060708");
      test("A sample ClValue.byteArray correctly serializes to bytes", () {
        final byteArrayValue = ClValue.byteArray(Uint8List.fromList(byteArray));
        final bytes = byteArrayValue.toBytes();
        expect(hex.encode(bytes), "0800000001020304050607080f08000000");
      });

      test("Sample ClValue.option(ClValue.byteArray) correctly serializes to bytes", () {
        final optionByteArrayValue = ClValue.option(ClValue.byteArray(Uint8List.fromList(byteArray)));
        final bytes = optionByteArrayValue.toBytes();
        expect(hex.encode(bytes), "090000000101020304050607080d0f08000000");
      });

      test("Sample ClValue.optionNone(ClTypeDescriptor(ClType.byteArray)) correctly serializes to bytes", () {
        final optionByteArrayValue = ClValue.optionNone(ClByteArrayTypeDescriptor(32));
        final bytes = optionByteArrayValue.toBytes();
        expect(hex.encode(bytes), "01000000000d0f20000000");
      });
    });

    group("ClValue.map", () {
      final map = {
        ClValue.string("key1"): ClValue.u32(1),
        ClValue.string("key2"): ClValue.u32(2),
      };
      test("A sample ClValue.map correctly serializes to bytes", () {
        final mapValue = ClValue.map(map);
        final bytes = mapValue.toBytes();
        expect(hex.encode(bytes), "1c00000002000000040000006b65793101000000040000006b65793202000000110a04");
      });

      test("Sample ClValue.option(ClValue.map) correctly serializes to bytes", () {
        final optionMapValue = ClValue.option(ClValue.map(map));
        final bytes = optionMapValue.toBytes();
        expect(hex.encode(bytes), "1d0000000102000000040000006b65793101000000040000006b657932020000000d110a04");
      });

      test("Sample ClValue.optionNone(ClValue.map) correctly serializes to bytes", () {
        final optionMapValue =
            ClValue.optionNone(ClMapTypeDescriptor(ClTypeDescriptor(ClType.string), ClTypeDescriptor(ClType.u32)));
        final bytes = optionMapValue.toBytes();
        expect(hex.encode(bytes), "01000000000d110a04");
      });
    });

    group("ClValue Result", () {
      final okValue = ClValue.ok(ClValue.u8(0xff), ClTypeDescriptor(ClType.string));
      final errorValue = ClValue.error(ClValue.string("Error!"), ClTypeDescriptor(ClType.unit));
      test("A sample ClValue.ok correctly serializes to bytes", () {
        final bytes = okValue.toBytes();
        expect(hex.encode(bytes), "0200000001ff10030a");
      });

      test("Sample ClValue.option(ClValue.ok)) correctly serializes to bytes", () {
        final optionOkValue = ClValue.option(okValue);
        final bytes = optionOkValue.toBytes();
        expect(hex.encode(bytes), "030000000101ff0d10030a");
      });

      test("ClValue.ok(ClValue.unit()) correctly serializes to bytes", () {
        final okValue = ClValue.ok(ClValue.unit(), ClTypeDescriptor(ClType.string));
        final bytes = okValue.toBytes();
        expect(hex.encode(bytes), "010000000110090a");
      });

      test("Sample ClValue.error correctly serializes to bytes", () {
        final bytes = errorValue.toBytes();
        expect(hex.encode(bytes), "0b00000000060000004572726f722110090a");
      });

      test("Sample option ClValue.error correctly serializes to bytes", () {
        final optionErrorValue = ClValue.option(errorValue);
        final bytes = optionErrorValue.toBytes();
        expect(hex.encode(bytes), "0c0000000100060000004572726f72210d10090a");
      });

      test("Sample ClValue.optionNone(resultType) correctly serializes to bytes", () {
        final optionOkValue =
            ClValue.optionNone(ClResultTypeDescriptor(ClTypeDescriptor(ClType.u8), ClTypeDescriptor(ClType.string)));
        final bytes = optionOkValue.toBytes();
        expect(hex.encode(bytes), "01000000000d10030a");
      });
    });

    group("ClValue.tuple1", () {
      final tuple1Value = ClValue.tuple1(ClValue.u32(17));
      test("A sample ClValue.tuple1(u32) correctly serializes to bytes", () {
        final bytes = tuple1Value.toBytes();
        expect(hex.encode(bytes), "04000000110000001204");
      });

      test("A sample ClValue.tuple1(string) correctly serializes to bytes", () {
        final bytes = ClValue.tuple1(ClValue.string("ABCDE")).toBytes();
        expect(hex.encode(bytes), "09000000050000004142434445120a");
      });

      test("Sample option ClValue.tuple1 correctly serializes to bytes", () {
        final optionTuple1Value = ClValue.option(ClValue.tuple1(ClValue.string("ABCDE")));
        final bytes = optionTuple1Value.toBytes();
        expect(hex.encode(bytes), "0a000000010500000041424344450d120a");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.tuple1(string))) correctly serializes to bytes", () {
        final optionTuple1Value = ClValue.optionNone(ClTuple1TypeDescriptor(ClTypeDescriptor(ClType.string)));
        final bytes = optionTuple1Value.toBytes();
        expect(hex.encode(bytes), "01000000000d120a");
      });
    });

    group("ClValue.tuple2", () {
      test("A sample ClValue.tuple2(u32, u32) correctly serializes to bytes", () {
        final tuple2Value = ClValue.tuple2(ClValue.u32(17), ClValue.u32(127));
        final bytes = tuple2Value.toBytes();
        expect(hex.encode(bytes), "08000000110000007f000000130404");
      });

      test("A sample ClValue.tuple2(u32, string) correctly serializes to bytes", () {
        final tuple2Value = ClValue.tuple2(ClValue.u32(127), ClValue.string("ABCDE"));
        final bytes = tuple2Value.toBytes();
        expect(hex.encode(bytes), "0d0000007f00000005000000414243444513040a");
      });

      test("Sample option ClValue.tuple2(u32, string)", () {
        final optionTuple2Value = ClValue.option(ClValue.tuple2(ClValue.u32(127), ClValue.string("ABCDE")));
        final bytes = optionTuple2Value.toBytes();
        expect(hex.encode(bytes), "0e000000017f0000000500000041424344450d13040a");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.tuple2(u32, string))) correctly serializes to bytes", () {
        final optionTuple2Value =
            ClValue.optionNone(ClTuple2TypeDescriptor(ClTypeDescriptor(ClType.u32), ClTypeDescriptor(ClType.string)));
        final bytes = optionTuple2Value.toBytes();
        expect(hex.encode(bytes), "01000000000d13040a");
      });
    });

    group("ClValue.tuple3", () {
      test("A sample ClValue.tuple3(u32, u32, u32) correctly serializes to bytes", () {
        final tuple3Value = ClValue.tuple3(ClValue.u32(17), ClValue.u32(127), ClValue.u32(17));
        final bytes = tuple3Value.toBytes();
        expect(hex.encode(bytes), "0c000000110000007f0000001100000014040404");
      });

      test("A sample ClValue.tuple3(u32, string, u32) correctly serializes to bytes", () {
        final tuple3Value = ClValue.tuple3(ClValue.u32(127), ClValue.string("ABCDE"), ClValue.u32(127));
        final bytes = tuple3Value.toBytes();
        expect(hex.encode(bytes), "110000007f0000000500000041424344457f00000014040a04");
      });

      test("Sample option ClValue.tuple3", () {
        final optionTuple3Value =
            ClValue.option(ClValue.tuple3(ClValue.u32(127), ClValue.string("ABCDE"), ClValue.u32(127)));
        final bytes = optionTuple3Value.toBytes();
        expect(hex.encode(bytes), "12000000017f0000000500000041424344457f0000000d14040a04");
      });

      test("ClValue.optionNone(ClTypeDescriptor(ClType.tuple3(u32, string, u32))) correctly serializes to bytes", () {
        final optionTuple3Value = ClValue.optionNone(ClTuple3TypeDescriptor(
            ClTypeDescriptor(ClType.u32), ClTypeDescriptor(ClType.string), ClTypeDescriptor(ClType.u32)));
        final bytes = optionTuple3Value.toBytes();
        expect(hex.encode(bytes), "01000000000d14040a04");
      });
    });
  });
}
