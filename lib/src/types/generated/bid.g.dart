// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../bid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bid _$BidFromJson(Map<String, dynamic> json) => Bid(
      const UrefJsonConverter().fromJson(json['bonding_purse'] as String),
      json['delegation_rate'] as int,
      const DelegatorJsonListConverter().fromJson(json['delegators'] as List),
      json['inactive'] as bool,
      BigInt.parse(json['staked_amount'] as String),
      const ClPublicKeyNullableJsonConverter()
          .fromJson(json['validator_public_key'] as String?),
      json['vesting_schedule'] == null
          ? null
          : VestingSchedule.fromJson(
              json['vesting_schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      'bonding_purse': const UrefJsonConverter().toJson(instance.bondingPurse),
      'delegation_rate': instance.delegationRate,
      'delegators':
          const DelegatorJsonListConverter().toJson(instance.delegators),
      'inactive': instance.inactive,
      'staked_amount': instance.stakedAmount.toString(),
      'validator_public_key': const ClPublicKeyNullableJsonConverter()
          .toJson(instance.validatorPublicKey),
      'vesting_schedule': instance.vestingSchedule?.toJson(),
    };

ValidatorBid _$ValidatorBidFromJson(Map<String, dynamic> json) => ValidatorBid(
      const ClPublicKeyJsonConverter().fromJson(json['public_key'] as String),
      Bid.fromJson(json['bid'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidatorBidToJson(ValidatorBid instance) =>
    <String, dynamic>{
      'public_key': const ClPublicKeyJsonConverter().toJson(instance.publicKey),
      'bid': instance.bid.toJson(),
    };
