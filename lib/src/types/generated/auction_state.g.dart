// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../auction_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionState _$AuctionStateFromJson(Map<String, dynamic> json) => AuctionState(
      (json['bids'] as List<dynamic>)
          .map((e) => ValidatorBid.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['block_height'] as int,
      (json['era_validators'] as List<dynamic>)
          .map((e) => EraValidators.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['state_root_hash'] as String,
    );

Map<String, dynamic> _$AuctionStateToJson(AuctionState instance) =>
    <String, dynamic>{
      'bids': instance.bids.map((e) => e.toJson()).toList(),
      'block_height': instance.blockHeight,
      'era_validators': instance.eraValidators.map((e) => e.toJson()).toList(),
      'state_root_hash': instance.stateRootHash,
    };
