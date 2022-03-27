import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';
import 'package:casper_dart_sdk/src/types/block.dart';

part 'generated/get_block.g.dart';

@JsonSerializable()
class GetBlockParams extends RpcParams {
  @JsonKey(name: 'block_identifier')
  BlockId blockId;

  factory GetBlockParams.fromJson(Map<String, dynamic> json) => _$GetBlockParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBlockParamsToJson(this);

  GetBlockParams(this.blockId) : super();
}

@JsonSerializable()
class GetBlockResult extends RpcResult {
  @JsonKey(name: 'block')
  Block? block;

  factory GetBlockResult.fromJson(Map<String, dynamic> json) => _$GetBlockResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBlockResultToJson(this);

  GetBlockResult(apiVersion, this.block) : super(apiVersion);
}