import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

part 'generated/get_state_root_hash.g.dart';

@JsonSerializable()
class GetStateRootHashParams extends RpcParams {
  @JsonKey(name: 'block_identifier')
  Map<String, dynamic> blockIdentifier;

  factory GetStateRootHashParams.fromJson(Map<String, dynamic> json) => _$GetStateRootHashParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStateRootHashParamsToJson(this);

  GetStateRootHashParams.fromBlockHash(String blockHash)
      : blockIdentifier = {"Hash": blockHash},
        super();

  GetStateRootHashParams.fromBlockHeight(int blockHeight)
      : blockIdentifier = {"Height": blockHeight},
        super();
  
  GetStateRootHashParams(this.blockIdentifier) : super();
}

@JsonSerializable()
class GetStateRootHashResult extends RpcResult {
  @JsonKey(name: 'state_root_hash')
  String stateRootHash;

  factory GetStateRootHashResult.fromJson(Map<String, dynamic> json) => _$GetStateRootHashResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStateRootHashResultToJson(this);

  GetStateRootHashResult(apiVersion, this.stateRootHash) : super(apiVersion);
}
