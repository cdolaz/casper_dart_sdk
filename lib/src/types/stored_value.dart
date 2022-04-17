import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/account.dart';
import 'package:casper_dart_sdk/src/types/bid.dart';
import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:casper_dart_sdk/src/types/contract.dart';
import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:casper_dart_sdk/src/types/era.dart';
import 'package:casper_dart_sdk/src/types/transfer.dart';
import 'package:casper_dart_sdk/src/types/unbonding_purse.dart';

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
