import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

part 'generated/put_deploy.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PutDeployParams extends RpcParams {
  Deploy deploy;


  factory PutDeployParams.fromJson(Map<String, dynamic> json) =>
      _$PutDeployParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PutDeployParamsToJson(this);

  PutDeployParams(this.deploy) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PutDeployResult extends RpcResult {
  String deployHash;
  factory PutDeployResult.fromJson(Map<String, dynamic> json) =>
      _$PutDeployResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PutDeployResultToJson(this);

  PutDeployResult(apiVersion, this.deployHash) : super(apiVersion);
}
