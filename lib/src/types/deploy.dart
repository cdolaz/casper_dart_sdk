import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:casper_dart_sdk/src/crpyt/key_pair.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/serde/byte_serializable.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:casper_dart_sdk/src/types/cl_public_key.dart';
import 'package:casper_dart_sdk/src/types/cl_signature.dart';
import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pointycastle/digests/blake2b.dart';

import 'executable_deploy_item.dart';

part 'generated/deploy.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Deploy implements ByteSerializable {
  @Cep57ChecksummedHexJsonConverter()
  late String hash;

  DeployHeader header;

  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem payment;

  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem session;

  List<DeployApproval> approvals = [];

  factory Deploy.fromJson(Map<String, dynamic> json) => _$DeployFromJson(json);
  Map<String, dynamic> toJson() => _$DeployToJson(this);

  Deploy(this.hash, this.header, this.payment, this.session, this.approvals);

  Deploy.create(this.header, this.payment, this.session) {
    header.bodyHash = Cep57Checksum.encode(bodyHash);
    hash = Cep57Checksum.encode(headerHash);
  }

  Future<Uint8List> sign(KeyPair pair) async {
    Uint8List signatureBytes = await pair.sign(Uint8List.fromList(hex.decode(hash)));
    addApproval(DeployApproval(ClSignature.fromBytes(signatureBytes, pair.publicKey.keyAlgorithm), pair.publicKey));
    return signatureBytes;
  }

  void addApproval(DeployApproval approval) {
    approvals.add(approval);
  }

  /// Verifies the approval signatures of the deploy
  /// Returns null if the signature is valid, otherwise
  /// returns the public key of the signer that failed to verify
  Future<ClPublicKey?> verifySignatures() async {
    for (DeployApproval approval in approvals) {
      if (!(await approval.signer.verify(Uint8List.fromList(hex.decode(hash)), approval.signature.bytes))) {
        return approval.signer;
      }
    }
    return null;
  }

  Uint8List get bodyHash {
    ByteDataWriter mem = ByteDataWriter();
    mem.write(payment.toBytes());
    mem.write(session.toBytes());
    final blake2 = Blake2bDigest(digestSize: 32);
    final body = mem.toBytes();
    blake2.update(body, 0, body.length);
    Uint8List hash = Uint8List(blake2.digestSize);
    blake2.doFinal(hash, 0);
    return hash;
  }

  Uint8List get headerHash {
    ByteDataWriter mem = ByteDataWriter();
    mem.write(header.toBytes());
    final blake2 = Blake2bDigest(digestSize: 32);
    final body = mem.toBytes();
    blake2.update(body, 0, body.length);
    Uint8List hash = Uint8List(blake2.digestSize);
    blake2.doFinal(hash, 0);
    return hash;
  }

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter();
    mem.write(header.toBytes());
    mem.write(hex.decode(hash));
    mem.write(payment.toBytes());
    mem.write(session.toBytes());
    mem.writeInt32(approvals.length);
    for (var approval in approvals) {
      mem.write(approval.toBytes());
    }
    return mem.toBytes();
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeployHeader implements ByteSerializable {
  @ClPublicKeyJsonConverter()
  ClPublicKey account;

  @DateTimeJsonConverter()
  DateTime timestamp;

  @HumanReadableDurationJsonConverter()
  Duration ttl;

  int gasPrice;

  @Cep57ChecksummedHexJsonConverter()
  late String bodyHash;

  List<String> dependencies;

  String chainName;

  factory DeployHeader.fromJson(Map<String, dynamic> json) => _$DeployHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$DeployHeaderToJson(this);

  DeployHeader(this.account, this.timestamp, this.ttl, this.gasPrice, this.bodyHash, this.dependencies, this.chainName);
  DeployHeader.withoutBodyHash(
      this.account, this.timestamp, this.ttl, this.gasPrice, this.dependencies, this.chainName);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter();
    mem.write(account.bytesWithKeyAlgorithmIdentifier);
    mem.writeUint64(timestamp.millisecondsSinceEpoch);
    mem.writeUint64(ttl.inMilliseconds);
    mem.writeUint64(gasPrice);
    mem.write(hex.decode(bodyHash));
    mem.writeInt32(dependencies.length);
    for (String dependency in dependencies) {
      mem.write(hex.decode(dependency));
    }
    mem.writeInt32(chainName.length);
    mem.write(utf8.encode(chainName));
    return mem.toBytes();
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeployApproval implements ByteSerializable {
  @ClSignatureJsonConverter()
  ClSignature signature;

  @ClPublicKeyJsonConverter()
  ClPublicKey signer;

  factory DeployApproval.fromJson(Map<String, dynamic> json) => _$DeployApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$DeployApprovalToJson(this);

  DeployApproval(this.signature, this.signer);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter();
    mem.write(signer.bytesWithKeyAlgorithmIdentifier);
    mem.write(signature.bytesWithKeyAlgorithmIdentifier);
    return mem.toBytes();
  }
}

class TimeToLiveJsonConverter implements JsonConverter<int, String> {
  const TimeToLiveJsonConverter();

  @override
  int fromJson(String json) {
    return int.parse(json);
  }

  @override
  String toJson(int value) {
    return value.toString();
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeployInfo {
  String deployHash;

  @AccountHashKeyJsonConverter()
  AccountHashKey from;

  BigInt gas;

  @UrefJsonConverter()
  Uref source;

  @TransferKeyJsonConverter()
  List<TransferKey> transfers;

  factory DeployInfo.fromJson(Map<String, dynamic> json) => _$DeployInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeployInfoToJson(this);

  DeployInfo(this.deployHash, this.from, this.gas, this.source, this.transfers);
}
