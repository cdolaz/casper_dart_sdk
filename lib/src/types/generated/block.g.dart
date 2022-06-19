// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      json['hash'] as String,
      BlockHeader.fromJson(json['header'] as Map<String, dynamic>),
      BlockBody.fromJson(json['body'] as Map<String, dynamic>),
      (json['proofs'] as List<dynamic>)
          .map((e) => BlockProof.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'hash': instance.hash,
      'header': instance.header.toJson(),
      'body': instance.body.toJson(),
      'proofs': instance.proofs.map((e) => e.toJson()).toList(),
    };

BlockHeader _$BlockHeaderFromJson(Map<String, dynamic> json) => BlockHeader()
  ..accumulatedSeed = json['accumulated_seed'] as String
  ..bodyHash = json['body_hash'] as String
  ..eraEnd = json['era_end'] == null
      ? null
      : EraEnd.fromJson(json['era_end'] as Map<String, dynamic>)
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
      'era_end': instance.eraEnd?.toJson(),
      'era_id': instance.eraId,
      'height': instance.height,
      'parent_hash': instance.parentHash,
      'protocol_version': instance.protocolVersion,
      'random_bit': instance.randomBit,
      'state_root_hash': instance.stateRootHash,
      'timestamp': const DateTimeJsonConverter().toJson(instance.timestamp),
    };

BlockBody _$BlockBodyFromJson(Map<String, dynamic> json) => BlockBody(
      (json['deploy_hashes'] as List<dynamic>).map((e) => e as String).toList(),
      const ClPublicKeyJsonConverter().fromJson(json['proposer'] as String),
      (json['transfer_hashes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BlockBodyToJson(BlockBody instance) => <String, dynamic>{
      'deploy_hashes': instance.deployHashes,
      'proposer': const ClPublicKeyJsonConverter().toJson(instance.proposer),
      'transfer_hashes': instance.transferHashes,
    };

BlockProof _$BlockProofFromJson(Map<String, dynamic> json) => BlockProof(
      const ClPublicKeyJsonConverter().fromJson(json['public_key'] as String),
      const ClSignatureJsonConverter().fromJson(json['signature'] as String),
    );

Map<String, dynamic> _$BlockProofToJson(BlockProof instance) =>
    <String, dynamic>{
      'public_key': const ClPublicKeyJsonConverter().toJson(instance.publicKey),
      'signature': const ClSignatureJsonConverter().toJson(instance.signature),
    };

EraEnd _$EraEndFromJson(Map<String, dynamic> json) => EraEnd(
      EraReport.fromJson(json['era_report'] as Map<String, dynamic>),
      const ValidatorWeightJsonListConverter()
          .fromJson(json['next_era_validator_weights'] as List),
    );

Map<String, dynamic> _$EraEndToJson(EraEnd instance) => <String, dynamic>{
      'era_report': instance.eraReport.toJson(),
      'next_era_validator_weights': const ValidatorWeightJsonListConverter()
          .toJson(instance.nextEraValidatorWeights),
    };

EraReport _$EraReportFromJson(Map<String, dynamic> json) => EraReport(
      const ClPublicKeyJsonListConverter()
          .fromJson(json['equivocators'] as List),
      const ClPublicKeyJsonListConverter()
          .fromJson(json['inactive_validators'] as List),
      (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EraReportToJson(EraReport instance) => <String, dynamic>{
      'equivocators':
          const ClPublicKeyJsonListConverter().toJson(instance.equivocators),
      'inactive_validators': const ClPublicKeyJsonListConverter()
          .toJson(instance.inactiveValidators),
      'rewards': instance.rewards.map((e) => e.toJson()).toList(),
    };

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
      json['amount'] as int,
      const ClPublicKeyJsonConverter().fromJson(json['validator'] as String),
    );

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
      'amount': instance.amount,
      'validator': const ClPublicKeyJsonConverter().toJson(instance.validator),
    };

BlockInfoShort _$BlockInfoShortFromJson(Map<String, dynamic> json) =>
    BlockInfoShort(
      const ClPublicKeyJsonConverter().fromJson(json['creator'] as String),
      json['era_id'] as int,
      json['hash'] as String,
      json['height'] as int,
      json['state_root_hash'] as String,
      const DateTimeJsonConverter().fromJson(json['timestamp'] as String),
    );

Map<String, dynamic> _$BlockInfoShortToJson(BlockInfoShort instance) =>
    <String, dynamic>{
      'creator': const ClPublicKeyJsonConverter().toJson(instance.creator),
      'era_id': instance.eraId,
      'hash': instance.hash,
      'height': instance.height,
      'state_root_hash': instance.stateRootHash,
      'timestamp': const DateTimeJsonConverter().toJson(instance.timestamp),
    };
