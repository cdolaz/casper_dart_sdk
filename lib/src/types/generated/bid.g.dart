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
      const PublicKeyJsonConverter()
          .fromJson(json['validator_public_key'] as String),
      VestingSchedule.fromJson(
          json['vesting_schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      'bonding_purse': const UrefJsonConverter().toJson(instance.bondingPurse),
      'delegation_rate': instance.delegationRate,
      'delegators':
          const DelegatorJsonListConverter().toJson(instance.delegators),
      'inactive': instance.inactive,
      'staked_amount': instance.stakedAmount.toString(),
      'validator_public_key':
          const PublicKeyJsonConverter().toJson(instance.publicKey),
      'vesting_schedule': instance.vestingSchedule,
    };
