// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_dictionary_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDictionaryItemParams _$GetDictionaryItemParamsFromJson(
        Map<String, dynamic> json) =>
    GetDictionaryItemParams(
      json['dictionary_identifier'] as Map<String, dynamic>,
      json['state_root_hash'] as String,
    );

Map<String, dynamic> _$GetDictionaryItemParamsToJson(
        GetDictionaryItemParams instance) =>
    <String, dynamic>{
      'dictionary_identifier': instance.dictionaryIdentifier,
      'state_root_hash': instance.stateRootHash,
    };

GetDictionaryItemResult _$GetDictionaryItemResultFromJson(
        Map<String, dynamic> json) =>
    GetDictionaryItemResult(
      json['api_version'],
      json['dictionary_key'] as String,
      const StoredValueJsonConverter()
          .fromJson(json['stored_value'] as Map<String, dynamic>),
      json['merkle_proof'] as String,
    );

Map<String, dynamic> _$GetDictionaryItemResultToJson(
        GetDictionaryItemResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'dictionary_key': instance.dictionaryKey,
      'stored_value':
          const StoredValueJsonConverter().toJson(instance.storedValue),
      'merkle_proof': instance.merkleProof,
    };
