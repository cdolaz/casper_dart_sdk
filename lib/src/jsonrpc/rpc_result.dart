import 'package:json_annotation/json_annotation.dart';

part 'generated/rpc_result.g.dart';

@JsonSerializable()
class RpcResult {
  @JsonKey(name: 'api_version')
  String apiVersion;

  factory RpcResult.fromJson(Map<String, dynamic> json) =>
      _$RpcResultFromJson(json);

  Map<String, dynamic> toJson() => _$RpcResultToJson(this);

  RpcResult(this.apiVersion);
}
