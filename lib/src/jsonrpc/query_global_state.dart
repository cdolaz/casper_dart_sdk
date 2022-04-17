
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/stored_value.dart';

part 'generated/query_global_state.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QueryGlobalStateParams extends RpcParams {
  String key;
  late Map<String, dynamic> stateIdentifier;
  List<String>? path;

  factory QueryGlobalStateParams.fromJson(Map<String, dynamic> json) => _$QueryGlobalStateParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QueryGlobalStateParamsToJson(this);

  QueryGlobalStateParams.fromPair(this.key, String hash, bool isBlockHash, [this.path]) : super() {
    if (isBlockHash) {
      stateIdentifier = {'BlockHash': hash};
    } else {
      stateIdentifier = {'StateRootHash': hash};
    }
  }

  QueryGlobalStateParams(this.key, this.stateIdentifier, [this.path]) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class QueryGlobalStateResult extends RpcResult {
  BlockHeader? blockHeader;
  @StoredValueJsonConverter()
  dynamic storedValue;
  String merkleProof;

  factory QueryGlobalStateResult.fromJson(Map<String, dynamic> json) => _$QueryGlobalStateResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QueryGlobalStateResultToJson(this);

  QueryGlobalStateResult(apiVersion, this.storedValue, this.blockHeader, this.merkleProof) : super(apiVersion);
}
