import 'package:json_annotation/json_annotation.dart';

part 'generated/peer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Peer {
  String nodeId;

  String address;

  factory Peer.fromJson(Map<String, dynamic> json) => _$PeerFromJson(json);

  Map<String, dynamic> toJson() => _$PeerToJson(this);

  Peer(this.nodeId, this.address);
}
