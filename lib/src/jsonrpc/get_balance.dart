import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

part 'generated/get_balance.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetBalanceParams extends RpcParams {
  String stateRootHash;
  @UrefJsonConverter()
  Uref purseUref;

  factory GetBalanceParams.fromJson(Map<String, dynamic> json) => _$GetBalanceParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBalanceParamsToJson(this);

  GetBalanceParams(this.stateRootHash, this.purseUref) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetBalanceResult extends RpcResult {
  BigInt balanceValue;
  String merkleProof;

  factory GetBalanceResult.fromJson(Map<String, dynamic> json) => _$GetBalanceResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBalanceResultToJson(this);

  GetBalanceResult(apiVersion, this.balanceValue, this.merkleProof) : super(apiVersion);
}
