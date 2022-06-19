// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBlockParams _$GetBlockParamsFromJson(Map<String, dynamic> json) =>
    GetBlockParams(
      BlockId.fromJson(json['block_identifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBlockParamsToJson(GetBlockParams instance) =>
    <String, dynamic>{
      'block_identifier': instance.blockId.toJson(),
    };

GetBlockResult _$GetBlockResultFromJson(Map<String, dynamic> json) =>
    GetBlockResult(
      json['api_version'],
      json['block'] == null
          ? null
          : Block.fromJson(json['block'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBlockResultToJson(GetBlockResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'block': instance.block?.toJson(),
    };
