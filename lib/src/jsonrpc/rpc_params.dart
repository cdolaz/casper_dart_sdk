import 'package:json_annotation/json_annotation.dart';

part 'generated/rpc_params.g.dart';

@JsonSerializable()
class RpcParams {
  factory RpcParams.fromJson(Map<String, dynamic> json) =>
      _$RpcParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RpcParamsToJson(this);

  RpcParams();
}
