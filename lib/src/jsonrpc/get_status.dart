import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/types/peer.dart';
import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';

part 'generated/get_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetStatusResult extends RpcResult {
  late String buildVersion;

  late String chainspecName;

  late BlockInfoShort? lastAddedBlockInfo;

  late String? nextUpgrade;

  @PublicKeyJsonConverter()
  late PublicKey ourPublicSigningKey;

  late List<Peer> peers;

  late String? roundLength;

  late String startingStateRootHash;
  
  @HumanReadableDurationJsonConverter()
  late Duration uptime;

  GetStatusResult(apiVersion) : super(apiVersion);

  factory GetStatusResult.fromJson(Map<String, dynamic> json) => _$GetStatusResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetStatusResultToJson(this);
}
