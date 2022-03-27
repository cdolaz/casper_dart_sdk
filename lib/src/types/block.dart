import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/helpers/json_utils.dart';

part 'generated/block.g.dart';

@JsonSerializable()
class Block {
  @JsonKey(name: 'hash')
  String hash;

  @JsonKey(name: 'header')
  BlockHeader header;

  // @JsonKey(name: 'body')
  // BlockBody body;

  // @JsonKey(name: 'proofs')
  // List<BlockProof> proofs;

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);

  Block(this.hash, this.header /*, this.body, this.proofs*/);
}

@JsonSerializable()
class BlockHeader {
  @JsonKey(name: 'accumulated_seed')
  late String accumulatedSeed;

  @JsonKey(name: 'body_hash')
  late String bodyHash;

  @JsonKey(name: 'era_end')
  late EraEnd eraEnd;

  @JsonKey(name: 'era_id')
  late int eraId;

  @JsonKey(name: 'height')
  late int height;

  @JsonKey(name: 'parent_hash')
  late String parentHash;

  @JsonKey(name: 'protocol_version')
  late String protocolVersion;

  @JsonKey(name: 'random_bit')
  late bool randomBit;

  @JsonKey(name: 'state_root_hash')
  late String stateRootHash;

  @JsonKey(name: 'timestamp')
  @DateTimeJsonConverter()
  late DateTime timestamp;

  factory BlockHeader.fromJson(Map<String, dynamic> json) => _$BlockHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$BlockHeaderToJson(this);

  BlockHeader();
}

@JsonSerializable()
class EraEnd {
  @JsonKey(name: 'era_report')
  EraReport eraReport;

  @JsonKey(name: 'next_era_validator_weights')
  List<ValidatorWeight> nextEraValidatorWeights;

  factory EraEnd.fromJson(Map<String, dynamic> json) => _$EraEndFromJson(json);
  Map<String, dynamic> toJson() => _$EraEndToJson(this);

  EraEnd(this.eraReport, this.nextEraValidatorWeights);
}

@JsonSerializable()
class EraReport {
  @JsonKey(name: 'equivocators')
  @PublicKeyJsonListConverter()
  List<PublicKey> equivocators;

  @JsonKey(name: 'inactive_validators')
  @PublicKeyJsonListConverter()
  List<PublicKey> inactiveValidators;

  @JsonKey(name: 'rewards')
  List<Reward> rewards;

  factory EraReport.fromJson(Map<String, dynamic> json) => _$EraReportFromJson(json);
  Map<String, dynamic> toJson() => _$EraReportToJson(this);

  EraReport(this.equivocators, this.inactiveValidators, this.rewards);
}

@JsonSerializable()
class Reward {
  @JsonKey(name: 'amount')
  int amount;

  @JsonKey(name: 'validator')
  @PublicKeyJsonConverter()
  PublicKey validator;

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
  Map<String, dynamic> toJson() => _$RewardToJson(this);

  Reward(this.amount, this.validator);
}

@JsonSerializable()
class ValidatorWeight {
  @JsonKey(name: 'validator')
  @PublicKeyJsonConverter()
  PublicKey validator;

  @JsonKey(name: 'weight')
  BigInt? weight;

  factory ValidatorWeight.fromJson(Map<String, dynamic> json) => _$ValidatorWeightFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatorWeightToJson(this);

  ValidatorWeight(this.validator, this.weight);
}

@JsonSerializable()
class BlockInfoShort {
  @JsonKey(name: 'creator')
  @PublicKeyJsonConverter()
  PublicKey creator;

  @JsonKey(name: 'era_id')
  int eraId;

  @JsonKey(name: 'hash')
  String hash;

  @JsonKey(name: 'height')
  int height;

  @JsonKey(name: 'state_root_hash')
  String stateRootHash;

  @JsonKey(name: 'timestamp')
  @DateTimeJsonConverter()
  DateTime timestamp;

  factory BlockInfoShort.fromJson(Map<String, dynamic> json) => _$BlockInfoShortFromJson(json);
  Map<String, dynamic> toJson() => _$BlockInfoShortToJson(this);

  BlockInfoShort(this.creator, this.eraId, this.hash, this.height, this.stateRootHash, this.timestamp);
}
