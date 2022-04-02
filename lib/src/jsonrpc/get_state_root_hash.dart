import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';
import 'package:casper_dart_sdk/src/types/block.dart';

part 'generated/get_state_root_hash.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetStateRootHashParams extends RpcParams {
  BlockId blockIdentifier;

  factory GetStateRootHashParams.fromJson(Map<String, dynamic> json) => _$GetStateRootHashParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStateRootHashParamsToJson(this);

  GetStateRootHashParams(this.blockIdentifier) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetStateRootHashResult extends RpcResult {
  String stateRootHash;

  factory GetStateRootHashResult.fromJson(Map<String, dynamic> json) => _$GetStateRootHashResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStateRootHashResultToJson(this);

  GetStateRootHashResult(apiVersion, this.stateRootHash) : super(apiVersion);
}
