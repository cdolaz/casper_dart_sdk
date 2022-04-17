import 'package:casper_dart_sdk/src/types/bid.dart';
import 'package:casper_dart_sdk/src/types/unbonding_purse.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/account.dart';
import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:casper_dart_sdk/src/types/transfer.dart';
import 'package:casper_dart_sdk/src/types/contract.dart';
import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:casper_dart_sdk/src/types/era.dart';

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

class StoredValueJsonConverter extends JsonConverter<dynamic, Map<String, dynamic>> {
  const StoredValueJsonConverter();

  @override
  dynamic fromJson(Map<String, dynamic> json) {
    String top = json.keys.first;
    final inner = json[top];
    top = top.toLowerCase();
    if (top == "contract") {
      return Contract.fromJson(inner);
    } else if (top == "clvalue") {
      return ClValue.fromJson(inner);
    } else if (top == "account") {
      return Account.fromJson(inner);
    } else if (top == "contractwasm") {
      return inner;
    } else if (top == "contractpackage") {
      return ContractPackage.fromJson(inner);
    } else if (top == "transfer") {
      return Transfer.fromJson(inner);
    } else if (top == "deployinfo") {
      return DeployInfo.fromJson(inner);
    } else if (top == "erainfo") {
      return EraInfo.fromJson(inner);
    } else if (top == "bid") {
      return Bid.fromJson(inner);
    } else if (top == "withdraw") {
      return UnbondingPurse.fromJson(inner);
    }
    throw UnsupportedError("Cannot deserialize stored value. ${json.keys.first} is not supported yet");
  }

  @override
  Map<String, dynamic> toJson(dynamic object) {
    throw UnimplementedError();
  }
}
