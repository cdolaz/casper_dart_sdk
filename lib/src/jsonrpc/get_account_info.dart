import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';
import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/account.dart';
import 'package:casper_dart_sdk/src/types/cl_public_key.dart';

part 'generated/get_account_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetAccountInfoParams extends RpcParams {
  @JsonKey(name: 'block_identifier')
  BlockId? blockId;

  @ClPublicKeyJsonConverter()
  ClPublicKey publicKey;

  factory GetAccountInfoParams.fromJson(Map<String, dynamic> json) => _$GetAccountInfoParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAccountInfoParamsToJson(this);

  GetAccountInfoParams(this.publicKey, this.blockId) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetAccountInfoResult extends RpcResult {
  Account account;
  String merkleProof;

  factory GetAccountInfoResult.fromJson(Map<String, dynamic> json) => _$GetAccountInfoResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAccountInfoResultToJson(this);

  GetAccountInfoResult(apiVersion, this.account, this.merkleProof) : super(apiVersion);
}