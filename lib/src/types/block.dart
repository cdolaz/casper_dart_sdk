import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';

part 'generated/block.g.dart';

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
