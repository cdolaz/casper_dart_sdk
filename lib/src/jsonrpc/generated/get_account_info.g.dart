// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountInfoParams _$GetAccountInfoParamsFromJson(
        Map<String, dynamic> json) =>
    GetAccountInfoParams(
      const ClPublicKeyJsonConverter().fromJson(json['public_key'] as String),
      json['block_identifier'] == null
          ? null
          : BlockId.fromJson(json['block_identifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAccountInfoParamsToJson(
        GetAccountInfoParams instance) =>
    <String, dynamic>{
      'block_identifier': instance.blockId?.toJson(),
      'public_key': const ClPublicKeyJsonConverter().toJson(instance.publicKey),
    };

GetAccountInfoResult _$GetAccountInfoResultFromJson(
        Map<String, dynamic> json) =>
    GetAccountInfoResult(
      json['api_version'],
      Account.fromJson(json['account'] as Map<String, dynamic>),
      json['merkle_proof'] as String,
    );

Map<String, dynamic> _$GetAccountInfoResultToJson(
        GetAccountInfoResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'account': instance.account.toJson(),
      'merkle_proof': instance.merkleProof,
    };
