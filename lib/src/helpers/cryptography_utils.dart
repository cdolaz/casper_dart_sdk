import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart' as crypt;
import 'package:pointycastle/export.dart' as pointycastle;
import 'package:tuple/tuple.dart';

Future<bool> verifySignatureEd25519(Uint8List publicKeyBytes, Uint8List messageBytes, Uint8List signatureBytes) async {
  final publicKey = crypt.SimplePublicKey(
    List<int>.unmodifiable(publicKeyBytes),
    type: crypt.KeyPairType.ed25519,
  );
  final signature = crypt.Signature(signatureBytes, publicKey: publicKey);
  final algorithm = crypt.Ed25519();
  return await algorithm.verify(messageBytes, signature: signature);
}

bool verifySignatureSecp256k1(Uint8List publicKeyBytes, Uint8List messageBytes, Uint8List signatureBytes) {
  final pointycastle.ECDomainParameters domainParams = pointycastle.ECDomainParameters("secp256k1");
  final pointycastle.ECPoint Q = domainParams.curve.decodePoint(publicKeyBytes)!;
  final signer = pointycastle.Signer("SHA-256/ECDSA");
  final pointycastle.ECPublicKey publicKey = pointycastle.ECPublicKey(Q, domainParams);
  signer.init(false, pointycastle.PublicKeyParameter(publicKey));
  return signer.verifySignature(messageBytes, secp256k1SignatureBytesToECSignature(signatureBytes));
}

pointycastle.ECSignature secp256k1SignatureBytesToECSignature(Uint8List signatureBytes) {
  BigInt r = BigInt.parse("0x" + hex.encode(signatureBytes.sublist(0, 32)));
  BigInt s = BigInt.parse("0x" + hex.encode(signatureBytes.sublist(32, 64)));
  return pointycastle.ECSignature(r, s);
}

Uint8List secp256k1SignatureToBytes(pointycastle.ECSignature signature) {
  final r = hex.decode(signature.r.toRadixString(16).padLeft(64, "0"));
  final s = hex.decode(signature.s.toRadixString(16).padLeft(64, "0"));
  final signatureBytes = Uint8List(64);
  signatureBytes.setRange(0, 32, r);
  signatureBytes.setRange(32, 64, s);
  return signatureBytes;
}

Future<crypt.SimpleKeyPair> generateEd25519KeyPair() async {
  final algorithm = crypt.Ed25519();
  return algorithm.newKeyPair();
}

Future<crypt.SimpleKeyPair> createEd25519KeyPairFromPrivateKey(List<int> privateKey) async {
  final algorithm = crypt.Ed25519();
  return algorithm.newKeyPairFromSeed(privateKey);
}
