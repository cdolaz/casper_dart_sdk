// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_auction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAuctionInfoParams _$GetAuctionInfoParamsFromJson(
        Map<String, dynamic> json) =>
    GetAuctionInfoParams(
      json['block_identifier'] == null
          ? null
          : BlockId.fromJson(json['block_identifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAuctionInfoParamsToJson(
        GetAuctionInfoParams instance) =>
    <String, dynamic>{
      'block_identifier': instance.blockId,
    };

GetAuctionInfoResult _$GetAuctionInfoResultFromJson(
        Map<String, dynamic> json) =>
    GetAuctionInfoResult(
      json['api_version'],
      json['auction_state'] == null
          ? null
          : AuctionState.fromJson(
              json['auction_state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAuctionInfoResultToJson(
        GetAuctionInfoResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'auction_state': instance.auctionState,
    };
