import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/named_arg.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NamedArg {
  String name;

  ClValue value;

  factory NamedArg.fromJson(Map<String, dynamic> json) =>
      _$NamedArgFromJson(json);
  Map<String, dynamic> toJson() => _$NamedArgToJson(this);

  NamedArg(this.name, this.value);
}
