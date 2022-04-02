import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

part 'generated/get_deploy.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetDeployParams extends RpcParams {
  String deployHash;

  factory GetDeployParams.fromJson(Map<String, dynamic> json) =>
      _$GetDeployParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDeployParamsToJson(this);

  GetDeployParams(this.deployHash) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetDeployResult extends RpcResult {
  Deploy deploy;

  factory GetDeployResult.fromJson(Map<String, dynamic> json) =>
      _$GetDeployResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDeployResultToJson(this);

  GetDeployResult(apiVersion, this.deploy) : super(apiVersion);
}
