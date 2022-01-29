import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'named_arg.g.dart';

@JsonSerializable()
class NamedArg {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'value')
  ClValue value;

  factory NamedArg.fromJson(Map<String, dynamic> json) =>
      _$NamedArgFromJson(json);
  Map<String, dynamic> toJson() => _$NamedArgToJson(this);

  NamedArg(this.name, this.value);
}
