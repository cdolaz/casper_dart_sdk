import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/types/signature.dart';
import 'package:json_annotation/json_annotation.dart';

import 'executable_deploy_item.dart';

part 'generated/deploy.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeployApproval {
  @SignatureJsonConverter()
  Signature signature;

  @PublicKeyJsonConverter()
  PublicKey signer;

  factory DeployApproval.fromJson(Map<String, dynamic> json) => _$DeployApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$DeployApprovalToJson(this);

  DeployApproval(this.signature, this.signer);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Deploy {
  @Cep57ChecksummedHexJsonConverter()
  String hash;

  DeployHeader header;

  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem payment;

  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem session;

  List<DeployApproval> approvals;

  factory Deploy.fromJson(Map<String, dynamic> json) => _$DeployFromJson(json);
  Map<String, dynamic> toJson() => _$DeployToJson(this);

  Deploy(this.hash, this.header, this.payment, this.session, this.approvals);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeployHeader {
  @PublicKeyJsonConverter()
  PublicKey account;

  @DateTimeJsonConverter()
  DateTime timestamp;

  @HumanReadableDurationJsonConverter()
  Duration ttl;

  int gasPrice;

  @Cep57ChecksummedHexJsonConverter()
  String bodyHash;

  List<String> dependencies;

  String chainName;

  factory DeployHeader.fromJson(Map<String, dynamic> json) => _$DeployHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$DeployHeaderToJson(this);

  DeployHeader(this.account, this.timestamp, this.ttl, this.gasPrice, this.bodyHash, this.dependencies, this.chainName);
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
