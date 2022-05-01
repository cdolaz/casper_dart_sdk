// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../unbonding_purse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnbondingPurse _$UnbondingPurseFromJson(Map<String, dynamic> json) =>
    UnbondingPurse(
      BigInt.parse(json['amount'] as String),
      const UrefJsonConverter().fromJson(json['bonding_purse'] as String),
      json['era_of_creation'] as int,
      const ClPublicKeyJsonConverter()
          .fromJson(json['unbonder_public_key'] as String),
      const ClPublicKeyJsonConverter()
          .fromJson(json['validator_public_key'] as String),
    );

Map<String, dynamic> _$UnbondingPurseToJson(UnbondingPurse instance) =>
    <String, dynamic>{
      'amount': instance.amount.toString(),
      'bonding_purse': const UrefJsonConverter().toJson(instance.bondingPurse),
      'era_of_creation': instance.eraOfCreation,
      'unbonder_public_key':
          const ClPublicKeyJsonConverter().toJson(instance.unbonderPublicKey),
      'validator_public_key':
          const ClPublicKeyJsonConverter().toJson(instance.validatorPublicKey),
    };
