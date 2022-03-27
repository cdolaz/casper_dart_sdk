// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStatusResult _$GetStatusResultFromJson(Map<String, dynamic> json) =>
    GetStatusResult(
      json['api_version'],
    )
      ..buildVersion = json['build_version'] as String
      ..chainspecName = json['chainspec_name'] as String
      ..lastAddedBlockInfo = json['last_added_block_info'] == null
          ? null
          : BlockInfoShort.fromJson(
              json['last_added_block_info'] as Map<String, dynamic>)
      ..nextUpgrade = json['next_upgrade'] as String?
      ..ourPublicSigningKey = const PublicKeyJsonConverter()
          .fromJson(json['our_public_signing_key'] as String)
      ..peers = (json['peers'] as List<dynamic>)
          .map((e) => Peer.fromJson(e as Map<String, dynamic>))
          .toList()
      ..roundLength = json['round_length'] as String?
      ..startingStateRootHash = json['starting_state_root_hash'] as String
      ..uptime = const HumanReadableDurationJsonConverter()
          .fromJson(json['uptime'] as String);

Map<String, dynamic> _$GetStatusResultToJson(GetStatusResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'build_version': instance.buildVersion,
      'chainspec_name': instance.chainspecName,
      'last_added_block_info': instance.lastAddedBlockInfo,
      'next_upgrade': instance.nextUpgrade,
      'our_public_signing_key':
          const PublicKeyJsonConverter().toJson(instance.ourPublicSigningKey),
      'peers': instance.peers,
      'round_length': instance.roundLength,
      'starting_state_root_hash': instance.startingStateRootHash,
      'uptime':
          const HumanReadableDurationJsonConverter().toJson(instance.uptime),
    };
