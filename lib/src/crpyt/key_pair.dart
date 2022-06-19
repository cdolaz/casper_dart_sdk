import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/helpers/cryptography_utils.dart';
import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:cryptography/cryptography.dart' as crypt;
import 'package:pointycastle/export.dart' as pc;
import 'package:secp256k1/secp256k1.dart' as secp256k1;

// Lack of good cryptography libraries for secp256k1 and ed25519 in Dart forces us to
// use multiple libraries to do these.

abstract class KeyPair {
  late ClPublicKey publicKey;

  KeyPair();

  Future<Uint8List> sign(Uint8List message);
  Future<bool> verify(Uint8List message, Uint8List signatureBytes);
}

class Secp256k1KeyPair extends KeyPair {
  final ECPublicKey _publicKey;
  final ECPrivateKey _privateKey;

  Secp256k1KeyPair(this._publicKey, this._privateKey) {
    final bytes = _publicKey.Q!.getEncoded(true);
    publicKey = ClPublicKey(bytes, KeyAlgorithm.secp256k1);
  }

  static Future<Secp256k1KeyPair> generate() {
    return Future(() {
      // Generate a new key pair
      final random = pc.FortunaRandom();
      random.seed(pc.KeyParameter(randomBytes(32)));

      final pc.ECKeyGenerator keyGenerator = pc.ECKeyGenerator();
      final keyParams = pc.ECKeyGeneratorParameters(pc.ECCurve_secp256k1());
      keyGenerator.init(pc.ParametersWithRandom(keyParams, random));

      final pair = keyGenerator.generateKeyPair();
      final privateKey = pair.privateKey as pc.ECPrivateKey;
      final publicKey = pair.publicKey as pc.ECPublicKey;

      return Secp256k1KeyPair(publicKey, privateKey);
    });
  }

  /// Loads a key pair from a PEM file [pemFile] containing the private key.
  static Future<Secp256k1KeyPair> loadFromPem(File pemFile) async {
    final pc.ECPrivateKey pcPrivateKey = CryptoUtils.ecPrivateKeyFromPem(await pemFile.readAsString());
    // Derive public key from private key
    secp256k1.PublicKey secp256k1PublicKey = secp256k1.PrivateKey(pcPrivateKey.d!).publicKey;
    final domainParameters = pcPrivateKey.parameters!;
    final point = domainParameters.curve.createPoint(secp256k1PublicKey.X, secp256k1PublicKey.Y);
    ECPublicKey pcPublicKey = ECPublicKey(point, domainParameters);
    return Secp256k1KeyPair(pcPublicKey, pcPrivateKey);
  }

  @override
  Future<Uint8List> sign(Uint8List message) {
    return Future(() {
      ECSignature signature = CryptoUtils.ecSign(_privateKey, message, algorithmName: "SHA-256/ECDSA");
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
}

class Ed25519KeyPair extends KeyPair {
  final crypt.SimpleKeyPair _keyPair;

  Ed25519KeyPair(this._keyPair);

  Future<ClPublicKey> initializeClPublicKey() async {
    final cryptographySimplePublicKey = await _keyPair.extractPublicKey();
    final publicKeyBytes = Uint8List.fromList(cryptographySimplePublicKey.bytes);
    publicKey = ClPublicKey(publicKeyBytes, KeyAlgorithm.ed25519);
    return publicKey;
  }

  static Future<Ed25519KeyPair> generate() async {
    final algorihm = crypt.Ed25519();
    final keyPair = await algorihm.newKeyPair();
    final result = Ed25519KeyPair(keyPair);
    await result.initializeClPublicKey();
    return result;
  }

  /// Loads the key pair from a PEM file [pemFile] containing the private key.
  static Future<Ed25519KeyPair> loadFromPem(File pemFile) async {
    try {
      final pemString = await pemFile.readAsString();
      final bytes = CryptoUtils.getBytesFromPEMString(pemString);
      final parser = ASN1Parser(bytes);
      final sequence = parser.nextObject() as ASN1Sequence;
      final octetString = sequence.elements![2] as ASN1OctetString;
      // Feels like a hack, but works (for private DER encoded ed25519 private key PEM files).
      final privateKeyBytes = octetString.valueBytes!.sublist(2);
      final algorithm = crypt.Ed25519();
      final keyPair = await algorithm.newKeyPairFromSeed(privateKeyBytes);
      final result = Ed25519KeyPair(keyPair);
      await result.initializeClPublicKey();
      return result;
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
}
