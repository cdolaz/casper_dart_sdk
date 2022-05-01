import 'dart:io';

import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group("ClPublicKey", () {
    // TODO: These tests fail. Find a good crypto library.
    // test("can read ed25519 public key from PEM file", () {
    //   ClPublicKey publicKey = ClPublicKey.fromPemFile(File("test/resources/sample-ed25519-pub.pem"));
    //   expect(publicKey.accountHex, equals("01381b36cd07Ad85348607ffE0fA3A2d033eA941D14763358eBEacE9C8aD3cB771"));
    // });

    // test("can read secp256k1 public key from PEM file", () {
    //   ClPublicKey publicKey = ClPublicKey.fromPemFile(File("test/resources/sample-secp256k1-pub.pem"));
    //   expect(publicKey.accountHex, equals("0203b2F8c0613d2d866948c46e296F09faEd9b029110d424d19d488A0C39a811ebBC"));
    // });
  });
}
