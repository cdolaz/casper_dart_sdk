// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../peer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Peer _$PeerFromJson(Map<String, dynamic> json) => Peer(
      json['node_id'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$PeerToJson(Peer instance) => <String, dynamic>{
      'node_id': instance.nodeId,
      'address': instance.address,
    };
