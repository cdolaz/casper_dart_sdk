import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/get_state_root_hash.g.dart';

@JsonSerializable()
class GetStateRootHashResult extends RpcResult {
  @JsonKey(name: 'state_root_hash')
  String stateRootHash;

  factory GetStateRootHashResult.fromJson(Map<String, dynamic> json) =>
      _$GetStateRootHashResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStateRootHashResultToJson(this);

  GetStateRootHashResult(apiVersion, this.stateRootHash) : super(apiVersion);
}
