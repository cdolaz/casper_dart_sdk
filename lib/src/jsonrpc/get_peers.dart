import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/types/peer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/get_peers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetPeersResult extends RpcResult {
  List<Peer> peers;

  factory GetPeersResult.fromJson(Map<String, dynamic> json) =>
      _$GetPeersResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetPeersResultToJson(this);

  GetPeersResult(apiVersion, this.peers) : super(apiVersion);
}
