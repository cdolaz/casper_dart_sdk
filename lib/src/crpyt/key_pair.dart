import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/helpers/cryptography_utils.dart';
import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart' as crypt;
import 'package:elliptic/elliptic.dart';
import 'package:pem/pem.dart';
import 'package:pointycastle/export.dart';
import 'package:secp256k1/secp256k1.dart' as secp256k1;

abstract class KeyPair {
  late ClPublicKey publicKey;

  KeyPair();

  // factory KeyPair.generate(KeyAlgorithm algorithm) {
  //   switch (algorithm) {
  //     case KeyAlgorithm.secp256k1:
  //       return Secp256k1KeyPair.generate();
  //     case KeyAlgorithm.ed25519:
  //       return Ed25519KeyPair.generate();
  //     default:
  //       throw Exception("Unsupported key algorithm: $algorithm");
  //   }
  // }

  bool hasPrivateKey();

  Future<Uint8List> sign(Uint8List message);
  Future<bool> verify(Uint8List message, Uint8List signatureBytes);
}

class Secp256k1KeyPair extends KeyPair {
  late ECPublicKey _publicKey;
  ECPrivateKey? _privateKey;

  Secp256k1KeyPair.generate() : super() {
    // Generate a new key pair
    final random = FortunaRandom();
    random.seed(KeyParameter(randomBytes(32)));

    final ECKeyGenerator keyGenerator = ECKeyGenerator();
    final keyParams = ECKeyGeneratorParameters(ECCurve_secp256k1());
    keyGenerator.init(ParametersWithRandom(keyParams, random));

    final pair = keyGenerator.generateKeyPair();
    _privateKey = pair.privateKey as ECPrivateKey;
    _publicKey = pair.publicKey as ECPublicKey;
    final bytes = _publicKey.Q!.getEncoded(true);
    publicKey = ClPublicKey(bytes, KeyAlgorithm.secp256k1);
  }

  /// Loads a key pair from a PEM file [pemFile] containing the private key.
  Secp256k1KeyPair.fromPem(File pemFile) {
    // Lack of good cryptography libraries for secp256k1 and ed25519 in Dart forces us to
    // use multiple libraries to do this.

    _privateKey = CryptoUtils.ecPrivateKeyFromPem(pemFile.readAsStringSync());
    // Derive public key from private key
    secp256k1.PrivateKey privateKey = secp256k1.PrivateKey(_privateKey!.d!);
    secp256k1.PublicKey secp256k1PublicKey = privateKey.publicKey;
    final domainParameters = _privateKey!.parameters!;
    final point = domainParameters.curve.createPoint(secp256k1PublicKey.X, secp256k1PublicKey.Y);
    ECPublicKey ecPublicKey = ECPublicKey(point, domainParameters);
    _publicKey = ecPublicKey;
    final bytes = _publicKey.Q!.getEncoded(true);
    publicKey = ClPublicKey(bytes, KeyAlgorithm.secp256k1);
  }

  @override
  Future<Uint8List> sign(Uint8List message) {
    if (!hasPrivateKey()) throw Exception("No private key present");
    return Future(() {
      ECSignature signature = CryptoUtils.ecSign(_privateKey!, message, algorithmName: "SHA-256/ECDSA");
      return secp256k1SignatureToBytes(signature);
    });
  }

  @override
  Future<bool> verify(Uint8List message, Uint8List signatureBytes) {
    return Future(() {
      final ECSignature signature = secp256k1SignatureBytesToECSignature(signatureBytes);
      return CryptoUtils.ecVerify(_publicKey, message, signature, algorithm: "SHA-256/ECDSA");
    });
  }

  @override
  bool hasPrivateKey() => _privateKey != null;
}

class Ed25519KeyPair extends KeyPair {
  late crypt.SimpleKeyPair _keyPair;

  Ed25519KeyPair();

  Future<void> generate() async {
    // Generate a new key pair
    _keyPair = await generateEd25519KeyPair();
    final cryptographySimplePublicKey = await _keyPair.extractPublicKey();
    final publicKeyBytes = Uint8List.fromList(cryptographySimplePublicKey.bytes);
    publicKey = ClPublicKey(publicKeyBytes, KeyAlgorithm.ed25519);
  }

  /// Loads the key pair from a PEM file [pemFile] containing the private key.
  Future<void> loadFromPem(File pemFile) async {
    try {
      final pemString = await pemFile.readAsString();
      final bytes = CryptoUtils.getBytesFromPEMString(pemString);
      final parser = ASN1Parser(bytes);
      final sequence = parser.nextObject() as ASN1Sequence;
      final octetString = sequence.elements![2] as ASN1OctetString;
      final privateKeyBytes = octetString.valueBytes!.sublist(2);
      _keyPair = await createEd25519KeyPairFromPrivateKey(privateKeyBytes.toList());
      publicKey = ClPublicKey(Uint8List.fromList((await _keyPair.extractPublicKey()).bytes), KeyAlgorithm.ed25519);
    } catch (e) {
      throw ArgumentError(
          "Unable to load private key from PEM file: Either an unsupported format, or invalid PEM file");
    }
  }

  @override
  Future<Uint8List> sign(Uint8List message) async {
    final signature = await crypt.Ed25519().sign(message.toList(), keyPair: _keyPair);
    return Uint8List.fromList(signature.bytes);
  }

  @override
  Future<bool> verify(Uint8List message, Uint8List signatureBytes) async {
    final crpytographyPublicKey = await _keyPair.extractPublicKey();
    final crypt.Signature signature = crypt.Signature(signatureBytes.toList(), publicKey: crpytographyPublicKey);
    return crypt.Ed25519().verify(message.toList(), signature: signature);
  }

  @override
  bool hasPrivateKey() {
    return true;
  }
}
