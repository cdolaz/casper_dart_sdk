// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_block_transfers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBlockTransfersParams _$GetBlockTransfersParamsFromJson(
        Map<String, dynamic> json) =>
    GetBlockTransfersParams(
      BlockId.fromJson(json['block_identifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBlockTransfersParamsToJson(
        GetBlockTransfersParams instance) =>
    <String, dynamic>{
      'block_identifier': instance.blockId.toJson(),
    };

GetBlockTransfersResult _$GetBlockTransfersResultFromJson(
        Map<String, dynamic> json) =>
    GetBlockTransfersResult(
      json['api_version'],
      json['block_hash'] as String,
      (json['transfers'] as List<dynamic>)
          .map((e) => Transfer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBlockTransfersResultToJson(
        GetBlockTransfersResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'block_hash': instance.blockHash,
      'transfers': instance.transfers.map((e) => e.toJson()).toList(),
    };
