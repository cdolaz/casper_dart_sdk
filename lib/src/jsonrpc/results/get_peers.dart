import 'package:casper_dart_sdk/src/jsonrpc/results/rpc_result.dart';
import 'package:casper_dart_sdk/src/types/peer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_peers.g.dart';

@JsonSerializable()
class GetPeersResult extends RpcResult {
  @JsonKey(name: 'peers')
  List<Peer> peers;

  factory GetPeersResult.fromJson(Map<String, dynamic> json) =>
      _$GetPeersResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetPeersResultToJson(this);

  GetPeersResult(apiVersion, this.peers) : super(apiVersion);
}
