import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/types/signature.dart';
import 'package:json_annotation/json_annotation.dart';

import 'executable_deploy_item.dart';

part 'generated/deploy.g.dart';

@JsonSerializable()
class DeployApproval {
  @JsonKey(name: 'signature')
  @SignatureJsonConverter()
  Signature signature;

  @JsonKey(name: 'signer')
  @PublicKeyJsonConverter()
  PublicKey signer;

  factory DeployApproval.fromJson(Map<String, dynamic> json) =>
      _$DeployApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$DeployApprovalToJson(this);

  DeployApproval(this.signature, this.signer);
}

@JsonSerializable()
class Deploy {
  @JsonKey(name: 'hash')
  @Cep57ChecksummedHexJsonConverter()
  String hash;

  @JsonKey(name: 'header')
  DeployHeader header;

  @JsonKey(name: 'payment')
  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem payment;

  @JsonKey(name: 'session')
  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem session;

  @JsonKey(name: 'approvals')
  List<DeployApproval> approvals;

  factory Deploy.fromJson(Map<String, dynamic> json) => _$DeployFromJson(json);
  Map<String, dynamic> toJson() => _$DeployToJson(this);

  Deploy(this.hash, this.header, this.payment, this.session, this.approvals);
}

@JsonSerializable()
class DeployHeader {
  @JsonKey(name: 'account')
  @PublicKeyJsonConverter()
  PublicKey account;

  @JsonKey(name: 'timestamp')
  @DateTimeJsonConverter()
  DateTime timestamp;

  @JsonKey(name: 'ttl')
  @HumanReadableDurationJsonConverter()
  Duration ttl;

  @JsonKey(name: 'gas_price')
  int gasPrice;

  @JsonKey(name: 'body_hash')
  @Cep57ChecksummedHexJsonConverter()
  String bodyHash;

  @JsonKey(name: 'dependencies')
  List<String> dependencies;

  @JsonKey(name: 'chain_name')
  String chainName;

  factory DeployHeader.fromJson(Map<String, dynamic> json) =>
      _$DeployHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$DeployHeaderToJson(this);

  DeployHeader(this.account, this.timestamp, this.ttl, this.gasPrice,
      this.bodyHash, this.dependencies, this.chainName);
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
