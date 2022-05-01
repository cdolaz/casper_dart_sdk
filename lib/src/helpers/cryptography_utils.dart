import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:pointycastle/export.dart' as pointycastle;

Future<bool> verifySignatureEd25519(Uint8List publicKeyBytes, Uint8List messageBytes, Uint8List signatureBytes) async {
  final publicKey = cryptography.SimplePublicKey(
    List<int>.unmodifiable(publicKeyBytes),
    type: cryptography.KeyPairType.ed25519,
  );
  final signature = cryptography.Signature(signatureBytes, publicKey: publicKey);
  final algorithm = cryptography.Ed25519();
  return await algorithm.verify(messageBytes, signature: signature);
}

Future<bool> verifySignatureSecp256k1(
    Uint8List publicKeyBytes, Uint8List messageBytes, Uint8List signatureBytes) async {
  return Future<bool>(() {
    final pointycastle.ECDomainParameters domainParams = pointycastle.ECDomainParameters("secp256k1");
    final pointycastle.ECPoint Q = domainParams.curve.decodePoint(publicKeyBytes)!;
    final signer = pointycastle.Signer("SHA-256/ECDSA");
    final pointycastle.ECPublicKey publicKey = pointycastle.ECPublicKey(Q, domainParams);
    signer.init(false, pointycastle.PublicKeyParameter(publicKey));
    BigInt r = BigInt.parse("0x" + hex.encode(signatureBytes.sublist(0, 32)));
    BigInt s = BigInt.parse("0x" + hex.encode(signatureBytes.sublist(32, 64)));
    return signer.verifySignature(messageBytes, pointycastle.ECSignature(r, s));
  });
}
