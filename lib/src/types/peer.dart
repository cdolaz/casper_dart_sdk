import 'package:json_annotation/json_annotation.dart';

part 'generated/peer.g.dart';

@JsonSerializable()
class Peer {
  @JsonKey(name: 'node_id')
  String nodeId;

  @JsonKey(name: 'address')
  String address;

  factory Peer.fromJson(Map<String, dynamic> json) => _$PeerFromJson(json);

  Map<String, dynamic> toJson() => _$PeerToJson(this);

  Peer(this.nodeId, this.address);
}
