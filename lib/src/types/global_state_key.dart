import 'dart:typed_data';

import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class GlobalStateKey {
  /// The key prefixed with key identifier string.
  late final String key;

  /// The type of the key that identifies a value stored in the global state.
  late final KeyIdentifier keyIdentifier;

  /// Bytes of the key without the key identifier byte
  Uint8List get headlessBytes {
    final headless = key.substring(key.lastIndexOf("-") + 1).toLowerCase();
    return Uint8List.fromList(hex.decode(headless));
  }

  GlobalStateKey();

  GlobalStateKey.fromPrefixedKey(String key) {
    final identifierStr = key.substring(0, key.lastIndexOf("-") + 1);
    final keyIdentifier = KeyIdentifierExt.fromPrefix(identifierStr);
    final headlessKey = key.substring(key.lastIndexOf("-") + 1);
    final bytes = GlobalStateKey._verifyChecksum(headlessKey);
    this.key = keyIdentifier.prefix + Cep57Checksum.encode(bytes);
    this.keyIdentifier = keyIdentifier;
  }

  GlobalStateKey.fromKey(this.keyIdentifier, String headlessKey) {
    final bytes = GlobalStateKey._verifyChecksum(headlessKey);
    key = keyIdentifier.prefix + Cep57Checksum.encode(bytes);
  }

  GlobalStateKey.fromPrefixedBytes(Uint8List bytes) {
    keyIdentifier = KeyIdentifierExt.fromIdentifierByte(bytes[0]);
    key = keyIdentifier.prefix + Cep57Checksum.encode(bytes.sublist(1));
  }

  GlobalStateKey.fromBytes(this.keyIdentifier, Uint8List bytes) {
    key = keyIdentifier.prefix + Cep57Checksum.encode(bytes);
  }

  static Uint8List _verifyChecksum(String key) {
    final decoded = Cep57Checksum.decode(key);
    final checksumResult = decoded.item1;
    final bytes = decoded.item2;
    if (checksumResult == Cep57ChecksumResult.invalid) {
      throw ArgumentError.value(key, 'key', 'Checksum verification failed');
    }
    return bytes;
  }
}

class AccountHashKey extends GlobalStateKey {
  AccountHashKey(String key) : super.fromKey(KeyIdentifier.account, key);
  AccountHashKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  AccountHashKey.fromPublicKey(PublicKey publicKey) : super.fromPrefixedKey(publicKey.accountHash);
  AccountHashKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.account, bytes);
}

class HashKey extends GlobalStateKey {
  HashKey(String key) : super.fromKey(KeyIdentifier.hash, key);
  HashKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  HashKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.hash, bytes);
}

/// Represents an unforgeable reference, containing an address in the network's global storage and
/// the [AccessRights] of the reference.
///
/// A [Uref] can be used to index entities such as [ClValue]s, or smart contracts.
class Uref extends GlobalStateKey {
  late AccessRights accessRights;

  /// Value contains key prefix and a access rights suffix.
  Uref(String value) {
    if (!value.startsWith(KeyIdentifier.uref.prefix)) {
      throw ArgumentError.value(value, 'value', 'Uref key must start with "${KeyIdentifier.uref.prefix}"');
    }
    final parts = value.split("-");
    if (parts.length != 3) {
      throw ArgumentError.value(value, 'value', 'Uref key must contain 3 parts, separated by "-"');
    }
    keyIdentifier = KeyIdentifier.uref;
    final key = parts[1];
    final accessRightsStr = parts[2];
    if (key.length != 64) {
      throw ArgumentError.value(value, 'value', 'Uref key must contain 32 bytes');
    }
    final bytes = GlobalStateKey._verifyChecksum(key);
    this.key = keyIdentifier.prefix + Cep57Checksum.encode(bytes) + "-" + accessRightsStr;
    accessRights = AccessRightsExt.fromString(accessRightsStr);
  }
}

enum AccessRights {
  none,
  read,
  write,
  readWrite,
  add,
  readAdd,
  addWrite,
  readAddWrite,
}

extension AccessRightsExt on AccessRights {
  static AccessRights fromString(String accessRightsStr) {
    final accessRightsByte = int.parse(accessRightsStr, radix: 10);
    switch (accessRightsByte) {
      case 0:
        return AccessRights.none;
      case 1:
        return AccessRights.read;
      case 2:
        return AccessRights.write;
      case 3:
        return AccessRights.readWrite;
      case 4:
        return AccessRights.add;
      case 5:
        return AccessRights.readAdd;
      case 6:
        return AccessRights.addWrite;
      case 7:
        return AccessRights.readAddWrite;
      default:
        throw ArgumentError.value(accessRightsStr, 'accessRightsStr', 'Unknown access rights value');
    }
  }
}

class TransferKey extends GlobalStateKey {
  TransferKey(String key) : super.fromKey(KeyIdentifier.transfer, key);
  TransferKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  TransferKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.transfer, bytes);
}

class DeployInfoKey extends GlobalStateKey {
  DeployInfoKey(String key) : super.fromKey(KeyIdentifier.deployInfo, key);
  DeployInfoKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  DeployInfoKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.deployInfo, bytes);
}

class EraInfoKey extends GlobalStateKey {
  EraInfoKey(String key) : super.fromKey(KeyIdentifier.eraInfo, key);
  EraInfoKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  EraInfoKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.eraInfo, bytes);
}

class BalanceKey extends GlobalStateKey {
  BalanceKey(String key) : super.fromKey(KeyIdentifier.balance, key);
  BalanceKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  BalanceKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.balance, bytes);
}

class BidKey extends GlobalStateKey {
  BidKey(String key) : super.fromKey(KeyIdentifier.bid, key);
  BidKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  BidKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.bid, bytes);
}

class WithdrawKey extends GlobalStateKey {
  WithdrawKey(String key) : super.fromKey(KeyIdentifier.withdraw, key);
  WithdrawKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  WithdrawKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.withdraw, bytes);
}

class DictionaryKey extends GlobalStateKey {
  DictionaryKey(String key) : super.fromKey(KeyIdentifier.dictionary, key);
  DictionaryKey.fromPrefixedKey(String key) : super.fromPrefixedKey(key);
  DictionaryKey.fromBytes(Uint8List bytes) : super.fromBytes(KeyIdentifier.dictionary, bytes);
}

enum KeyIdentifier { account, hash, uref, transfer, deployInfo, eraInfo, balance, bid, withdraw, dictionary }

extension KeyIdentifierExt on KeyIdentifier {
  String get prefix {
    switch (this) {
      case KeyIdentifier.account:
        return "account-hash-";
      case KeyIdentifier.hash:
        return "hash-";
      case KeyIdentifier.uref:
        return "uref-";
      case KeyIdentifier.transfer:
        return "transfer-";
      case KeyIdentifier.deployInfo:
        return "deploy-";
      case KeyIdentifier.eraInfo:
        return "era-";
      case KeyIdentifier.balance:
        return "balance-";
      case KeyIdentifier.bid:
        return "bid-";
      case KeyIdentifier.withdraw:
        return "withdraw-";
      case KeyIdentifier.dictionary:
        return "dictionary-";
    }
  }

  static KeyIdentifier fromIdentifierByte(int byte) {
    switch (byte) {
      case 0x00:
        return KeyIdentifier.account;
      case 0x01:
        return KeyIdentifier.hash;
      case 0x02:
        return KeyIdentifier.uref;
      case 0x03:
        return KeyIdentifier.transfer;
      case 0x04:
        return KeyIdentifier.deployInfo;
      case 0x05:
        return KeyIdentifier.eraInfo;
      case 0x06:
        return KeyIdentifier.balance;
      case 0x07:
        return KeyIdentifier.bid;
      case 0x08:
        return KeyIdentifier.withdraw;
      case 0x09:
        return KeyIdentifier.dictionary;
      default:
        throw ArgumentError.value(byte, 'byte', 'Unknown key identifier byte');
    }
  }

  static KeyIdentifier fromPrefix(String prefix) {
    switch (prefix) {
      case "account-hash-":
        return KeyIdentifier.account;
      case "hash-":
        return KeyIdentifier.hash;
      case "uref-":
        return KeyIdentifier.uref;
      case "transfer-":
        return KeyIdentifier.transfer;
      case "deploy-":
        return KeyIdentifier.deployInfo;
      case "era-":
        return KeyIdentifier.eraInfo;
      case "balance-":
        return KeyIdentifier.balance;
      case "bid-":
        return KeyIdentifier.bid;
      case "withdraw-":
        return KeyIdentifier.withdraw;
      case "dictionary-":
        return KeyIdentifier.dictionary;
      default:
        throw ArgumentError.value(prefix, 'prefix', 'Unknown key prefix');
    }
  }
}

// Json converters
class AccountHashKeyJsonConverter extends JsonConverter<AccountHashKey, String> {
  const AccountHashKeyJsonConverter();

  @override
  AccountHashKey fromJson(String json) {
    return AccountHashKey.fromPrefixedKey(json);
  }

  @override
  String toJson(AccountHashKey object) {
    return object.key;
  }
}

class HashKeyJsonConverter extends JsonConverter<HashKey, String> {
  const HashKeyJsonConverter();

  @override
  HashKey fromJson(String json) {
    return HashKey.fromPrefixedKey(json);
  }

  @override
  String toJson(HashKey object) {
    return object.key;
  }
}

class UrefJsonConverter extends JsonConverter<Uref, String> {
  const UrefJsonConverter();

  @override
  Uref fromJson(String json) {
    return Uref(json);
  }

  @override
  String toJson(Uref object) {
    return object.key;
  }
}

class TransferKeyJsonConverter extends JsonConverter<TransferKey, String> {
  const TransferKeyJsonConverter();

  @override
  TransferKey fromJson(String json) {
    return TransferKey.fromPrefixedKey(json);
  }

  @override
  String toJson(TransferKey object) {
    return object.key;
  }
}

class DeployInfoKeyJsonConverter extends JsonConverter<DeployInfoKey, String> {
  const DeployInfoKeyJsonConverter();

  @override
  DeployInfoKey fromJson(String json) {
    return DeployInfoKey.fromPrefixedKey(json);
  }

  @override
  String toJson(DeployInfoKey object) {
    return object.key;
  }
}

class EraInfoKeyJsonConverter extends JsonConverter<EraInfoKey, String> {
  const EraInfoKeyJsonConverter();

  @override
  EraInfoKey fromJson(String json) {
    return EraInfoKey.fromPrefixedKey(json);
  }

  @override
  String toJson(EraInfoKey object) {
    return object.key;
  }
}

class BalanceKeyJsonConverter extends JsonConverter<BalanceKey, String> {
  const BalanceKeyJsonConverter();

  @override
  BalanceKey fromJson(String json) {
    return BalanceKey.fromPrefixedKey(json);
  }

  @override
  String toJson(BalanceKey object) {
    return object.key;
  }
}

class BidKeyJsonConverter extends JsonConverter<BidKey, String> {
  const BidKeyJsonConverter();

  @override
  BidKey fromJson(String json) {
    return BidKey.fromPrefixedKey(json);
  }

  @override
  String toJson(BidKey object) {
    return object.key;
  }
}

class WithdrawKeyJsonConverter extends JsonConverter<WithdrawKey, String> {
  const WithdrawKeyJsonConverter();

  @override
  WithdrawKey fromJson(String json) {
    return WithdrawKey.fromPrefixedKey(json);
  }

  @override
  String toJson(WithdrawKey object) {
    return object.key;
  }
}

class DictionaryKeyJsonConverter extends JsonConverter<DictionaryKey, String> {
  const DictionaryKeyJsonConverter();

  @override
  DictionaryKey fromJson(String json) {
    return DictionaryKey.fromPrefixedKey(json);
  }

  @override
  String toJson(DictionaryKey object) {
    return object.key;
  }
}
