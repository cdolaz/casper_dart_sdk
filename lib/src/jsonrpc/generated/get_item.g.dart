// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetItemParams _$GetItemParamsFromJson(Map<String, dynamic> json) =>
    GetItemParams(
      json['key'] as String,
      json['state_root_hash'] as String,
      (json['path'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetItemParamsToJson(GetItemParams instance) =>
    <String, dynamic>{
      'key': instance.key,
      'state_root_hash': instance.stateRootHash,
      'path': instance.path,
    };

GetItemResult _$GetItemResultFromJson(Map<String, dynamic> json) =>
    GetItemResult(
      json['api_version'],
      const StoredValueJsonConverter()
          .fromJson(json['stored_value'] as Map<String, dynamic>),
      json['merkle_proof'] as String,
    );

Map<String, dynamic> _$GetItemResultToJson(GetItemResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'stored_value':
          const StoredValueJsonConverter().toJson(instance.storedValue),
      'merkle_proof': instance.merkleProof,
    };
