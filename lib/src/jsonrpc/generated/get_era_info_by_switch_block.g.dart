// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_era_info_by_switch_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEraInfoBySwitchBlockParams _$GetEraInfoBySwitchBlockParamsFromJson(
        Map<String, dynamic> json) =>
    GetEraInfoBySwitchBlockParams(
      json['block_identifier'] == null
          ? null
          : BlockId.fromJson(json['block_identifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetEraInfoBySwitchBlockParamsToJson(
        GetEraInfoBySwitchBlockParams instance) =>
    <String, dynamic>{
      'block_identifier': instance.blockId,
    };

GetEraInfoBySwitchBlockResult _$GetEraInfoBySwitchBlockResultFromJson(
        Map<String, dynamic> json) =>
    GetEraInfoBySwitchBlockResult(
      json['api_version'],
      json['era_summary'] == null
          ? null
          : EraSummary.fromJson(json['era_summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetEraInfoBySwitchBlockResultToJson(
        GetEraInfoBySwitchBlockResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'era_summary': instance.eraSummary,
    };
