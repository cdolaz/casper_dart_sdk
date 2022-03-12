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

@JsonSerializable()
class StoredContractByNameDeployItem extends ExecutableDeployItem {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'entry_point')
  String entryPoint;

  factory StoredContractByNameDeployItem.fromJson(Map<String, dynamic> json) =>
      _$StoredContractByNameDeployItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoredContractByNameDeployItemToJson(this);

  StoredContractByNameDeployItem(
      this.name, this.entryPoint, List<NamedArg> args)
      : super(args);
}

@JsonSerializable()
class StoredContractByHashDeployItem extends ExecutableDeployItem {
  @JsonKey(name: 'hash')
  @HexBytesWithCep57ChecksumConverter()
  String hash;

  @JsonKey(name: 'entry_point')
  String entryPoint;

  factory StoredContractByHashDeployItem.fromJson(Map<String, dynamic> json) =>
      _$StoredContractByHashDeployItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoredContractByHashDeployItemToJson(this);

  StoredContractByHashDeployItem(
      this.hash, this.entryPoint, List<NamedArg> args)
      : super(args);
}

@JsonSerializable()
class StoredVersionedContractByHashDeployItem extends ExecutableDeployItem {
  @JsonKey(name: 'hash')
  @HexBytesWithCep57ChecksumConverter()
  String hash;

  @JsonKey(name: 'version')
  int? version;

  @JsonKey(name: 'entry_point')
  String entryPoint;

  factory StoredVersionedContractByHashDeployItem.fromJson(
          Map<String, dynamic> json) =>
      _$StoredVersionedContractByHashDeployItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$StoredVersionedContractByHashDeployItemToJson(this);

  StoredVersionedContractByHashDeployItem(
      this.hash, this.version, this.entryPoint, List<NamedArg> args)
      : super(args);
}

@JsonSerializable()
class StoredVersionedContractByNameDeployItem extends ExecutableDeployItem {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'version')
  int? version;

  @JsonKey(name: 'entry_point')
  String entryPoint;

  factory StoredVersionedContractByNameDeployItem.fromJson(
          Map<String, dynamic> json) =>
      _$StoredVersionedContractByNameDeployItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$StoredVersionedContractByNameDeployItemToJson(this);

  StoredVersionedContractByNameDeployItem(
      this.name, this.version, this.entryPoint, List<NamedArg> args)
      : super(args);
}

@JsonSerializable()
class TransferDeployItem extends ExecutableDeployItem {
  factory TransferDeployItem.fromJson(Map<String, dynamic> json) =>
      _$TransferDeployItemFromJson(json);
  
  Map<String, dynamic> toJson() => _$TransferDeployItemToJson(this);

  TransferDeployItem(List<NamedArg> args) : super(args);
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
    } else if (top == "StoredContractByName") {
      created = StoredContractByNameDeployItem.fromJson(inner);
    } else if (top == "StoredContractByHash") {
      created = StoredContractByHashDeployItem.fromJson(inner);
    } else if (top == "StoredVersionedContractByName") {
      created = StoredVersionedContractByNameDeployItem.fromJson(inner);
    } else if (top == "StoredVersionedContractByHash") {
      created = StoredVersionedContractByHashDeployItem.fromJson(inner);
    } else if (top == "Transfer") {
      created = TransferDeployItem.fromJson(inner);
    } else {
      throw Exception("Unknown deploy item type: $top");
    }

    return created;
  }

  @override
  Map<String, dynamic> toJson(ExecutableDeployItem value) {
    // TODO
    return {};
  }
}
