import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';

part 'generated/named_key.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NamedKey {
  String name;

  @GlobalStateKeyJsonConverter()
  GlobalStateKey key;

  factory NamedKey.fromJson(Map<String, dynamic> json) => _$NamedKeyFromJson(json);
  Map<String, dynamic> toJson() => _$NamedKeyToJson(this);

  NamedKey(this.name, this.key);
}
