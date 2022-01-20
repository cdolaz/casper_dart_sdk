import 'package:casper_dart_sdk/src/types/peer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_peers_result.g.dart';

@JsonSerializable()
class GetPeersResult {
  @JsonKey(name: 'api_version')
  String apiVersion;

  @JsonKey(name: 'peers')
  List<Peer> peers;

  factory GetPeersResult.fromJson(Map<String, dynamic> json) =>
      _$GetPeersResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetPeersResultToJson(this);

  GetPeersResult(this.apiVersion, this.peers);
}
