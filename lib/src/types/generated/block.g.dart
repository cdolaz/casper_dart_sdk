// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      json['hash'] as String,
      BlockHeader.fromJson(json['header'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'hash': instance.hash,
      'header': instance.header,
    };

BlockHeader _$BlockHeaderFromJson(Map<String, dynamic> json) => BlockHeader()
  ..accumulatedSeed = json['accumulated_seed'] as String
  ..bodyHash = json['body_hash'] as String
  ..eraEnd = EraEnd.fromJson(json['era_end'] as Map<String, dynamic>)
  ..eraId = json['era_id'] as int
  ..height = json['height'] as int
  ..parentHash = json['parent_hash'] as String
  ..protocolVersion = json['protocol_version'] as String
  ..randomBit = json['random_bit'] as bool
  ..stateRootHash = json['state_root_hash'] as String
  ..timestamp =
      const DateTimeJsonConverter().fromJson(json['timestamp'] as String);

Map<String, dynamic> _$BlockHeaderToJson(BlockHeader instance) =>
    <String, dynamic>{
      'accumulated_seed': instance.accumulatedSeed,
      'body_hash': instance.bodyHash,
      'era_end': instance.eraEnd,
      'era_id': instance.eraId,
      'height': instance.height,
      'parent_hash': instance.parentHash,
      'protocol_version': instance.protocolVersion,
      'random_bit': instance.randomBit,
      'state_root_hash': instance.stateRootHash,
      'timestamp': const DateTimeJsonConverter().toJson(instance.timestamp),
    };

EraEnd _$EraEndFromJson(Map<String, dynamic> json) => EraEnd(
      EraReport.fromJson(json['era_report'] as Map<String, dynamic>),
      (json['next_era_validator_weights'] as List<dynamic>)
          .map((e) => ValidatorWeight.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EraEndToJson(EraEnd instance) => <String, dynamic>{
      'era_report': instance.eraReport,
      'next_era_validator_weights': instance.nextEraValidatorWeights,
    };

EraReport _$EraReportFromJson(Map<String, dynamic> json) => EraReport(
      const PublicKeyJsonListConverter()
          .fromJson(json['equivocators'] as List<String>),
      const PublicKeyJsonListConverter()
          .fromJson(json['inactive_validators'] as List<String>),
      (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EraReportToJson(EraReport instance) => <String, dynamic>{
      'equivocators':
          const PublicKeyJsonListConverter().toJson(instance.equivocators),
      'inactive_validators': const PublicKeyJsonListConverter()
          .toJson(instance.inactiveValidators),
      'rewards': instance.rewards,
    };

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
      json['amount'] as int,
      const PublicKeyJsonConverter().fromJson(json['validator'] as String),
    );

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
      'amount': instance.amount,
      'validator': const PublicKeyJsonConverter().toJson(instance.validator),
    };

ValidatorWeight _$ValidatorWeightFromJson(Map<String, dynamic> json) =>
    ValidatorWeight(
      const PublicKeyJsonConverter().fromJson(json['validator'] as String),
      json['weight'] == null ? null : BigInt.parse(json['weight'] as String),
    );

Map<String, dynamic> _$ValidatorWeightToJson(ValidatorWeight instance) =>
    <String, dynamic>{
      'validator': const PublicKeyJsonConverter().toJson(instance.validator),
      'weight': instance.weight?.toString(),
    };

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
