import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

import 'package:casper_dart_sdk/src/types/stored_value.dart';

part 'generated/get_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetItemParams extends RpcParams {
  String key;
  String stateRootHash;
  List<String>? path;

  factory GetItemParams.fromJson(Map<String, dynamic> json) => _$GetItemParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetItemParamsToJson(this);

  GetItemParams(this.key, this.stateRootHash, [this.path]) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetItemResult extends RpcResult {
  @StoredValueJsonConverter()
  dynamic storedValue;
  String merkleProof;

  factory GetItemResult.fromJson(Map<String, dynamic> json) => _$GetItemResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetItemResultToJson(this);

  GetItemResult(apiVersion, this.storedValue, this.merkleProof) : super(apiVersion);
}
