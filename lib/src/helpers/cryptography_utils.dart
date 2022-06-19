import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart' as crypt;
import 'package:pointycastle/export.dart' as pc;

// Some crpytography utils for standalone usage.

Future<bool> verifySignatureEd25519(Uint8List publicKeyBytes, Uint8List messageBytes, Uint8List signatureBytes) async {
  final publicKey = crypt.SimplePublicKey(
    List<int>.unmodifiable(publicKeyBytes),
    type: crypt.KeyPairType.ed25519,
  );
  final signature = crypt.Signature(signatureBytes, publicKey: publicKey);
  final algorithm = crypt.Ed25519();
  return await algorithm.verify(messageBytes, signature: signature);
}

Future<bool> verifySignatureSecp256k1(Uint8List publicKeyBytes, Uint8List messageBytes, Uint8List signatureBytes) {
  return Future(() {
    final pc.ECDomainParameters domainParams = pc.ECDomainParameters("secp256k1");
    final pc.ECPoint Q = domainParams.curve.decodePoint(publicKeyBytes)!;
    final signer = pc.Signer("SHA-256/ECDSA");
    final pc.ECPublicKey publicKey = pc.ECPublicKey(Q, domainParams);
    signer.init(false, pc.PublicKeyParameter(publicKey));
    return signer.verifySignature(messageBytes, secp256k1SignatureBytesToECSignature(signatureBytes));
  });
}

pc.ECSignature secp256k1SignatureBytesToECSignature(Uint8List signatureBytes) {
  BigInt r = BigInt.parse("0x" + hex.encode(signatureBytes.sublist(0, 32)));
  BigInt s = BigInt.parse("0x" + hex.encode(signatureBytes.sublist(32, 64)));
  return pc.ECSignature(r, s);
}

Uint8List secp256k1SignatureToBytes(pc.ECSignature signature) {
  final r = hex.decode(signature.r.toRadixString(16).padLeft(64, "0"));
  final s = hex.decode(signature.s.toRadixString(16).padLeft(64, "0"));
  final signatureBytes = Uint8List(64);
  signatureBytes.setRange(0, 32, r);
  signatureBytes.setRange(32, 64, s);
  return signatureBytes;
}
