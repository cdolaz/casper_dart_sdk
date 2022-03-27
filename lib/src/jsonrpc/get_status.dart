import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/types/peer.dart';
import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';

part 'generated/get_status.g.dart';

@JsonSerializable()
class GetStatusResult extends RpcResult {
  @JsonKey(name: 'build_version')
  late String buildVersion;

  @JsonKey(name: 'chainspec_name')
  late String chainspecName;

  @JsonKey(name: 'last_added_block_info')
  late BlockInfoShort? lastAddedBlockInfo;

  @JsonKey(name: 'next_upgrade')
  late String? nextUpgrade;

  @JsonKey(name: 'our_public_signing_key')
  @PublicKeyJsonConverter()
  late PublicKey ourPublicSigningKey;

  @JsonKey(name: 'peers')
  late List<Peer> peers;

  @JsonKey(name: 'round_length')
  late String? roundLength;

  @JsonKey(name: 'starting_state_root_hash')
  late String startingStateRootHash;

  GetStatusResult(apiVersion) : super(apiVersion);

  factory GetStatusResult.fromJson(Map<String, dynamic> json) => _$GetStatusResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStatusResultToJson(this);
}
