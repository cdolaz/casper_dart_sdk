// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockInfoShort _$BlockInfoShortFromJson(Map<String, dynamic> json) =>
    BlockInfoShort(
      const PublicKeyJsonConverter().fromJson(json['creator'] as String),
      json['era_id'] as int,
      json['hash'] as String,
      json['height'] as int,
      json['state_root_hash'] as String,
      const DateTimeJsonConverter().fromJson(json['timestamp'] as String),
    );

Map<String, dynamic> _$BlockInfoShortToJson(BlockInfoShort instance) =>
    <String, dynamic>{
      'creator': const PublicKeyJsonConverter().toJson(instance.creator),
      'era_id': instance.eraId,
      'hash': instance.hash,
      'height': instance.height,
      'state_root_hash': instance.stateRootHash,
      'timestamp': const DateTimeJsonConverter().toJson(instance.timestamp),
    };
