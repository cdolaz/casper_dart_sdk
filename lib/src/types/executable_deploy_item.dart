import 'dart:typed_data';

import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:json_annotation/json_annotation.dart';

import 'named_arg.dart';

part 'executable_deploy_item.g.dart';

abstract class ExecutableDeployItem {
  @JsonKey(name: 'args')
  @NamedArgsJsonConverter()
  List<NamedArg> args;

  ExecutableDeployItem(this.args);
}

@JsonSerializable()
class ModuleBytesDeployItem extends ExecutableDeployItem {
  @JsonKey(name: 'module_bytes')
  String moduleBytes;

  factory ModuleBytesDeployItem.fromJson(Map<String, dynamic> json) =>
      _$ModuleBytesDeployItemFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleBytesDeployItemToJson(this);

  ModuleBytesDeployItem(List<NamedArg> args, this.moduleBytes) : super(args);
}

class NamedArgsJsonConverter
    extends JsonConverter<List<NamedArg>, List<dynamic>> {
  const NamedArgsJsonConverter();

  @override
  List<NamedArg> fromJson(List<dynamic> json) {
    // Parse runtime args
    final List<NamedArg> args = <NamedArg>[];
    for (int i = 0; i < json.length; i++) {
      final List<dynamic> arg = json[i];
      final String name = arg[0];
      final Map<String, dynamic> value = arg[1];
      args.add(NamedArg(name, ClValue.fromJson(value)));
    }
    return args;
  }

  @override
  List<dynamic> toJson(List<NamedArg> object) {
    // Serialize runtime args
    final List<dynamic> args = List.empty();
    for (int i = 0; i < object.length; i++) {
      final NamedArg arg = object[i];
      args.add([arg.name, arg.value.toJson()]);
    }
    return args;
  }
}

class ExecutableDeployItemJsonConverter
    implements JsonConverter<ExecutableDeployItem, Map<String, dynamic>> {
  const ExecutableDeployItemJsonConverter();

  @override
  ExecutableDeployItem fromJson(Map<String, dynamic> json) {
    final String top = json.keys.first;
    final Map<String, dynamic> inner = json[top];
    ExecutableDeployItem created;
    if (top == "ModuleBytes") {
      created = ModuleBytesDeployItem.fromJson(inner);
    } else {
      throw Exception("Unknown deploy item type: $top");
    }

    return created;
  }

  @override
  Map<String, dynamic> toJson(ExecutableDeployItem value) {
    return {};
  }
}