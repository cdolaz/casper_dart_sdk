import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/types/signature.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/helpers/json_utils.dart';

part 'generated/block.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Block {
  String hash;

  BlockHeader header;

  BlockBody body;

  List<BlockProof> proofs;

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);

  Block(this.hash, this.header, this.body, this.proofs);
}

@JsonSerializable(ignoreUnannotated: true, createFactory: false, createToJson: false)
class BlockId {
  dynamic _id; // String (hash) or int (height)

  factory BlockId.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("Hash")) {
      return BlockId.fromHash(json['Hash']);
    } else {
      // Height
      return BlockId.fromHeight(json['Height']);
    }
  }

  Map<String, dynamic> toJson() {
    if (_id is String) {
      return {"Hash": _id};
    } else {
      // Height
      return {"Height": _id};
    }
  }

  String? get hash => _id is String ? _id : null;
  int? get height => _id is int ? _id : null;

  @override
  bool operator ==(other) {
    if (other is BlockId) {
      if (_id is String) {
        return other._id == _id;
      } else {
        // Height
        return other._id == _id;
      }
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _id.hashCode;

  BlockId.fromHash(String hash) {
    _id = hash;
  }

  BlockId.fromHeight(int height) {
    _id = height;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlockHeader {
  late String accumulatedSeed;

  late String bodyHash;

  late EraEnd? eraEnd;

  late int eraId;

  late int height;

  late String parentHash;

  late String protocolVersion;

  late bool randomBit;

  late String stateRootHash;

  @DateTimeJsonConverter()
  late DateTime timestamp;

  factory BlockHeader.fromJson(Map<String, dynamic> json) => _$BlockHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$BlockHeaderToJson(this);

  BlockHeader();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlockBody {
  List<String> deployHashes;

  @PublicKeyJsonConverter()
  PublicKey proposer;

  List<String> transferHashes;

  factory BlockBody.fromJson(Map<String, dynamic> json) => _$BlockBodyFromJson(json);
  Map<String, dynamic> toJson() => _$BlockBodyToJson(this);

  BlockBody(this.deployHashes, this.proposer, this.transferHashes);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlockProof {
  @PublicKeyJsonConverter()
  PublicKey publicKey;

  @SignatureJsonConverter()
  Signature signature;

  factory BlockProof.fromJson(Map<String, dynamic> json) => _$BlockProofFromJson(json);
  Map<String, dynamic> toJson() => _$BlockProofToJson(this);

  BlockProof(this.publicKey, this.signature);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EraEnd {
  EraReport eraReport;

  List<ValidatorWeight> nextEraValidatorWeights;

  factory EraEnd.fromJson(Map<String, dynamic> json) => _$EraEndFromJson(json);
  Map<String, dynamic> toJson() => _$EraEndToJson(this);

  EraEnd(this.eraReport, this.nextEraValidatorWeights);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EraReport {
  @PublicKeyJsonListConverter()
  List<PublicKey> equivocators;

  @PublicKeyJsonListConverter()
  List<PublicKey> inactiveValidators;

  List<Reward> rewards;

  factory EraReport.fromJson(Map<String, dynamic> json) => _$EraReportFromJson(json);
  Map<String, dynamic> toJson() => _$EraReportToJson(this);

  EraReport(this.equivocators, this.inactiveValidators, this.rewards);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Reward {
  int amount;

  @PublicKeyJsonConverter()
  PublicKey validator;

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
  Map<String, dynamic> toJson() => _$RewardToJson(this);

  Reward(this.amount, this.validator);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ValidatorWeight {
  @PublicKeyJsonConverter()
  PublicKey validator;

  BigInt? weight;

  factory ValidatorWeight.fromJson(Map<String, dynamic> json) => _$ValidatorWeightFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatorWeightToJson(this);

  ValidatorWeight(this.validator, this.weight);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlockInfoShort {
  @PublicKeyJsonConverter()
  PublicKey creator;

  int eraId;

  String hash;

  int height;

  String stateRootHash;

  @DateTimeJsonConverter()
  DateTime timestamp;

  factory BlockInfoShort.fromJson(Map<String, dynamic> json) => _$BlockInfoShortFromJson(json);
  Map<String, dynamic> toJson() => _$BlockInfoShortToJson(this);

  BlockInfoShort(this.creator, this.eraId, this.hash, this.height, this.stateRootHash, this.timestamp);
}
