enum KeyAlgorithm {
  ed25519,
  secp256k1,
}

extension KeyAlgorithmExt on KeyAlgorithm {
  String get name => toString().split('.').last.toUpperCase();
  int get value => index + 1;
  int get identifierByte => value;
  String get identifierByteHex => value.toRadixString(16).padLeft(2, '0');
  int get publicKeyLength {
    switch (this) {
      case KeyAlgorithm.ed25519:
        return 32;
      case KeyAlgorithm.secp256k1:
        // Compressed public key is 33 bytes.
        return 33;
    }
  }
}

KeyAlgorithm keyAlgorithmFromIdentifierByte(int value) {
  switch (value) {
    case 1:
      return KeyAlgorithm.ed25519;
    case 2:
      return KeyAlgorithm.secp256k1;
    default:
      throw ArgumentError.value(value, 'value', 'Unknown key algorithm');
  }
}
