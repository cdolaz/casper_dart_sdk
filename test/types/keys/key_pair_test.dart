import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/crpyt/key_pair.dart';
import 'package:casper_dart_sdk/src/helpers/cryptography_utils.dart';
import 'package:secp256k1/secp256k1.dart' as secp256k1;
import 'package:test/test.dart';

void main() {
  group("Key Pair", () {
    group("secp256k1", () {
      test("can create new secp256k1 key pair", () {
        List<Uint8List> keys = [];
        for (int i = 0; i < 10; i++) {
          final keyPair = Secp256k1KeyPair.generate();
          expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.secp256k1);
          for (int j = 0; j < keys.length; j++) {
            expect(false, keyPair.publicKey.bytes == keys[j]);
          }
          keys.add(keyPair.publicKey.bytes);
        }
      });

      test("can sign & verify a message with secp256k1 key pair", () async {
        final keyPair = Secp256k1KeyPair.generate();
        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        final signatureSecond = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
        expect(await keyPair.verify(message, signatureSecond), isTrue);
      });

      test("can read from PEM file of a private key", () async {
        final keyPair = Secp256k1KeyPair.fromPem(File("./test/resources/sample-secp256k1-private.pem"));
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.secp256k1);
        expect(keyPair.publicKey.accountHex.toLowerCase(),
            "0203daeb08f212e4d9aa83f7d669ac565c6385f5dbdab359e02bef8d3c7644ceb818");

        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
      });
    });

    group("ed25519", () {
      test("can create new ed25519 key pair", () async {
        final keyPair = Ed25519KeyPair();
        await keyPair.generate();
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.ed25519);
      });

      test("can sign & verify a message with ed25519 key pair", () async {
        final keyPair = Ed25519KeyPair();
        await keyPair.generate();
        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        final signatureSecond = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
        expect(await keyPair.verify(message, signatureSecond), isTrue);
      });

      test("can read from PEM file of a private key", () async {
        final keyPair = Ed25519KeyPair();
        await keyPair.loadFromPem(File("./test/resources/sample-ed25519-private.pem"));
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.ed25519);
      });

      test("can sign & verify a message with a private key read from PEM file", () async {
        final keyPair = Ed25519KeyPair();
        await keyPair.loadFromPem(File("./test/resources/sample-ed25519-private.pem"));
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.ed25519);

        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
      });
    });
  });
}
