import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';

import 'package:casper_dart_sdk/src/types/stored_value.dart';

part 'generated/get_dictionary_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetDictionaryItemParams extends RpcParams {
  late Map<String, dynamic> dictionaryIdentifier;
  String stateRootHash;

  factory GetDictionaryItemParams.fromJson(Map<String, dynamic> json) => _$GetDictionaryItemParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDictionaryItemParamsToJson(this);

  GetDictionaryItemParams.fromDictionaryItemKey(String key, this.stateRootHash) : super() {
    dictionaryIdentifier = {'Dictionary': key};
  }

  GetDictionaryItemParams.withAccountKey(
      String accountKey, String dictionaryName, String dictionaryItemKey, this.stateRootHash)
      : super() {
    dictionaryIdentifier = {
      'AccountNamedKey': {
        'key': accountKey,
        'dictionary_name': dictionaryName,
        'dictionary_item_key': dictionaryItemKey
      }
    };
  }

  GetDictionaryItemParams.withContractKey(
      String contractKey, String dictionaryName, String dictionaryItemKey, this.stateRootHash)
      : super() {
    dictionaryIdentifier = {
      'ContractNamedKey': {
        'key': contractKey,
        'dictionary_name': dictionaryName,
        'dictionary_item_key': dictionaryItemKey
      }
    };
  }

  GetDictionaryItemParams.withSeedUref(Uref seedUref, String dictionaryItemKey, this.stateRootHash) : super() {
    dictionaryIdentifier= {
      'URef': {
        'seed_uref': seedUref.key,
        'dictionary_item_key': dictionaryItemKey
      }
    };
  }

  GetDictionaryItemParams(this.dictionaryIdentifier, this.stateRootHash) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetDictionaryItemResult extends RpcResult {
  String dictionaryKey;
  @StoredValueJsonConverter()
  dynamic storedValue;
  String merkleProof;

  factory GetDictionaryItemResult.fromJson(Map<String, dynamic> json) => _$GetDictionaryItemResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDictionaryItemResultToJson(this);

  GetDictionaryItemResult(apiVersion, this.dictionaryKey, this.storedValue, this.merkleProof) : super(apiVersion);
}
