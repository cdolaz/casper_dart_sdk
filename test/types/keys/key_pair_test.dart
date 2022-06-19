import 'dart:io';
import 'dart:typed_data';

import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:test/test.dart';

void main() {
  group("Key Pair", () {
    group("secp256k1", () {
      test("can create new secp256k1 key pair", () async {
        List<Uint8List> keys = [];
        for (int i = 0; i < 10; i++) {
          final keyPair = await Secp256k1KeyPair.generate();
          expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.secp256k1);
          for (int j = 0; j < keys.length; j++) {
            expect(false, keyPair.publicKey.bytes == keys[j]);
          }
          keys.add(keyPair.publicKey.bytes);
        }
      });

      test("can sign & verify a message with secp256k1 key pair", () async {
        final keyPair = await Secp256k1KeyPair.generate();
        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        final signatureSecond = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
        expect(await keyPair.verify(message, signatureSecond), isTrue);
      });

      test("can read from PEM file of a private key", () async {
        final keyPair = await Secp256k1KeyPair.loadFromPem(File("./test/resources/sample-secp256k1-private.pem"));
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
        final keyPair = await Ed25519KeyPair.generate();
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.ed25519);
      });

      test("can sign & verify a message with ed25519 key pair", () async {
        final keyPair = await Ed25519KeyPair.generate();
        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        final signatureSecond = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
        expect(await keyPair.verify(message, signatureSecond), isTrue);
      });

      test("can read from PEM file of a private key", () async {
        final keyPair = await Ed25519KeyPair.loadFromPem(File("./test/resources/sample-ed25519-private.pem"));
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.ed25519);
      });

      test("can sign & verify a message with a private key read from PEM file", () async {
        final keyPair = await Ed25519KeyPair.loadFromPem(File("./test/resources/sample-ed25519-private.pem"));
        expect(keyPair.publicKey.keyAlgorithm, KeyAlgorithm.ed25519);

        var message = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        final signature = await keyPair.sign(message);
        expect(await keyPair.verify(message, signature), isTrue);
      });
    });
  });
}
