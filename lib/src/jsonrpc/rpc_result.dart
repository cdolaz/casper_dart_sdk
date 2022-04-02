import 'package:json_annotation/json_annotation.dart';

part 'generated/rpc_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RpcResult {
  String apiVersion;

  factory RpcResult.fromJson(Map<String, dynamic> json) =>
      _$RpcResultFromJson(json);

  Map<String, dynamic> toJson() => _$RpcResultToJson(this);

  RpcResult(this.apiVersion);
}
