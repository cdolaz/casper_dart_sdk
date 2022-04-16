// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBalanceParams _$GetBalanceParamsFromJson(Map<String, dynamic> json) =>
    GetBalanceParams(
      json['state_root_hash'] as String,
      const UrefJsonConverter().fromJson(json['purse_uref'] as String),
    );

Map<String, dynamic> _$GetBalanceParamsToJson(GetBalanceParams instance) =>
    <String, dynamic>{
      'state_root_hash': instance.stateRootHash,
      'purse_uref': const UrefJsonConverter().toJson(instance.purseUref),
    };

GetBalanceResult _$GetBalanceResultFromJson(Map<String, dynamic> json) =>
    GetBalanceResult(
      json['api_version'],
      BigInt.parse(json['balance_value'] as String),
      json['merkle_proof'] as String,
    );

Map<String, dynamic> _$GetBalanceResultToJson(GetBalanceResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'balance_value': instance.balanceValue.toString(),
      'merkle_proof': instance.merkleProof,
    };
