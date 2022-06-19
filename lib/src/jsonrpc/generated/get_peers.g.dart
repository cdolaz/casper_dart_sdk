// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_peers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPeersResult _$GetPeersResultFromJson(Map<String, dynamic> json) =>
    GetPeersResult(
      json['api_version'],
      (json['peers'] as List<dynamic>)
          .map((e) => Peer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPeersResultToJson(GetPeersResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'peers': instance.peers.map((e) => e.toJson()).toList(),
    };
