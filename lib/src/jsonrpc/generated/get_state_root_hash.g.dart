// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_state_root_hash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStateRootHashParams _$GetStateRootHashParamsFromJson(
        Map<String, dynamic> json) =>
    GetStateRootHashParams(
      json['block_identifier'] as String,
    );

Map<String, dynamic> _$GetStateRootHashParamsToJson(
        GetStateRootHashParams instance) =>
    <String, dynamic>{
      'block_identifier': instance.blockIdentifier,
    };

GetStateRootHashResult _$GetStateRootHashResultFromJson(
        Map<String, dynamic> json) =>
    GetStateRootHashResult(
      json['api_version'],
      json['state_root_hash'] as String,
    );

Map<String, dynamic> _$GetStateRootHashResultToJson(
        GetStateRootHashResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'state_root_hash': instance.stateRootHash,
    };
