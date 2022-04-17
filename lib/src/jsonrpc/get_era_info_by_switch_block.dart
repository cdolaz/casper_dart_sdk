import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';

import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/era.dart';

part 'generated/get_era_info_by_switch_block.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetEraInfoBySwitchBlockParams {
  @JsonKey(name: 'block_identifier')
  BlockId? blockId;

  factory GetEraInfoBySwitchBlockParams.fromJson(Map<String, dynamic> json) =>
      _$GetEraInfoBySwitchBlockParamsFromJson(json);
  Map<String, dynamic> toJson() => _$GetEraInfoBySwitchBlockParamsToJson(this);

  GetEraInfoBySwitchBlockParams(this.blockId);  
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetEraInfoBySwitchBlockResult extends RpcResult {
  EraSummary? eraSummary;

  factory GetEraInfoBySwitchBlockResult.fromJson(Map<String, dynamic> json) =>
      _$GetEraInfoBySwitchBlockResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetEraInfoBySwitchBlockResultToJson(this);

  GetEraInfoBySwitchBlockResult(apiVersion, this.eraSummary) : super(apiVersion);
}