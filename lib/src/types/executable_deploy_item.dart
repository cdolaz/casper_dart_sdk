import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:casper_dart_sdk/src/serde/byte_serializable.dart';
import 'package:casper_dart_sdk/src/types/named_arg.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';

import 'package:buffer/buffer.dart';

part 'generated/executable_deploy_item.g.dart';

abstract class ExecutableDeployItem implements ByteSerializable {
  @JsonKey(name: 'args')
  @NamedArgsJsonConverter()
  late List<NamedArg> args;
  int get tag;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt32(args.length);
    for (NamedArg arg in args) {
      mem.write(arg.toBytes());
    }
    return mem.toBytes();
  }

  ExecutableDeployItem.withArgs(this.args);
  ExecutableDeployItem();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ModuleBytesDeployItem extends ExecutableDeployItem {
  @NullableHexStringBytesJsonConverter()
  late Uint8List? moduleBytes;

  factory ModuleBytesDeployItem.fromJson(Map<String, dynamic> json) => _$ModuleBytesDeployItemFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleBytesDeployItemToJson(this);

  @override
  int get tag => 0x00;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(tag);
    if (moduleBytes == null || moduleBytes!.isEmpty) {
      mem.writeInt32(0);
    } else {
      mem.writeInt32(moduleBytes!.length);
      mem.write(moduleBytes!);
    }
    Uint8List argsBytes = super.toBytes();
    mem.write(argsBytes);
    return mem.toBytes();
  }

  ModuleBytesDeployItem.fromAmount(BigInt amount) : super.withArgs([NamedArg('amount', ClValue.u512(amount))]) {
    moduleBytes = Uint8List.fromList([]);
  }

  ModuleBytesDeployItem() : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoredContractByHashDeployItem extends ExecutableDeployItem {
  @HexBytesWithCep57ChecksumConverter()
  String hash;

  String entryPoint;

  factory StoredContractByHashDeployItem.fromJson(Map<String, dynamic> json) =>
      _$StoredContractByHashDeployItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoredContractByHashDeployItemToJson(this);

  @override
  int get tag => 0x01;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(tag);
    mem.write(hex.decode(hash));
    List<int> entryPointBytes = utf8.encode(entryPoint);
    mem.writeInt32(entryPointBytes.length);
    mem.write(entryPointBytes);
    Uint8List argsBytes = super.toBytes();
    mem.write(argsBytes);
    return mem.toBytes();
  }

  StoredContractByHashDeployItem(this.hash, this.entryPoint, [List<NamedArg> args = const []]) : super.withArgs(args);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoredContractByNameDeployItem extends ExecutableDeployItem {
  String name;

  String entryPoint;

  factory StoredContractByNameDeployItem.fromJson(Map<String, dynamic> json) =>
      _$StoredContractByNameDeployItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoredContractByNameDeployItemToJson(this);

  @override
  int get tag => 0x02;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(tag);
    List<int> nameBytes = utf8.encode(name);
    mem.writeInt32(nameBytes.length);
    mem.write(nameBytes);
    List<int> entryPointBytes = utf8.encode(entryPoint);
    mem.writeInt32(entryPointBytes.length);
    mem.write(entryPointBytes);
    Uint8List argsBytes = super.toBytes();
    mem.write(argsBytes);
    return mem.toBytes();
  }

  StoredContractByNameDeployItem(this.name, this.entryPoint, [List<NamedArg> args = const []]) : super.withArgs(args);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoredVersionedContractByHashDeployItem extends ExecutableDeployItem {
  @HexBytesWithCep57ChecksumConverter()
  String hash;

  int? version;

  String entryPoint;

  factory StoredVersionedContractByHashDeployItem.fromJson(Map<String, dynamic> json) =>
      _$StoredVersionedContractByHashDeployItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoredVersionedContractByHashDeployItemToJson(this);

  @override
  int get tag => 0x03;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(tag);
    mem.write(hex.decode(hash));
    if (version == null) {
      mem.writeUint8(0x00);
    } else {
      mem.writeUint8(0x01);
      mem.writeUint32(version!);
    }
    List<int> entryPointBytes = utf8.encode(entryPoint);
    mem.writeInt32(entryPointBytes.length);
    mem.write(entryPointBytes);
    Uint8List argsBytes = super.toBytes();
    mem.write(argsBytes);
    return mem.toBytes();
  }

  StoredVersionedContractByHashDeployItem(this.hash, this.version, this.entryPoint, [List<NamedArg> args = const []])
      : super.withArgs(args);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoredVersionedContractByNameDeployItem extends ExecutableDeployItem {
  String name;

  int? version;

  String entryPoint;

  factory StoredVersionedContractByNameDeployItem.fromJson(Map<String, dynamic> json) =>
      _$StoredVersionedContractByNameDeployItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoredVersionedContractByNameDeployItemToJson(this);

  @override
  int get tag => 0x04;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(tag);
    List<int> nameBytes = utf8.encode(name);
    mem.writeInt32(nameBytes.length);
    mem.write(nameBytes);
    if (version == null) {
      mem.writeUint8(0x00);
    } else {
      mem.writeUint8(0x01);
      mem.writeUint32(version!);
    }
    List<int> entryPointBytes = utf8.encode(entryPoint);
    mem.writeInt32(entryPointBytes.length);
    mem.write(entryPointBytes);
    Uint8List argsBytes = super.toBytes();
    mem.write(argsBytes);
    return mem.toBytes();
  }

  StoredVersionedContractByNameDeployItem(this.name, this.version, this.entryPoint, [List<NamedArg> args = const []])
      : super.withArgs(args);
}

@JsonSerializable()
class TransferDeployItem extends ExecutableDeployItem {
  factory TransferDeployItem.fromJson(Map<String, dynamic> json) => _$TransferDeployItemFromJson(json);
  Map<String, dynamic> toJson() => _$TransferDeployItemToJson(this);

  @override
  int get tag => 0x05;

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(tag);
    Uint8List argsBytes = super.toBytes();
    mem.write(argsBytes);
    return mem.toBytes();
  }

  TransferDeployItem.transfer(BigInt amount, AccountHashKey targetAccount, [int? id]) : super() {
    args = [
      NamedArg(
        'amount',
        ClValue.u512(amount),
      ),
      NamedArg(
        'target',
        ClValue.byteArray(targetAccount.headlessBytes),
      ),
      NamedArg(
        'id',
        id == null ? ClValue.optionNone(ClTypeDescriptor(ClType.u64)) : ClValue.option(ClValue.u64(id)),
      ),
    ];
  }
  TransferDeployItem() : super();
}

class NamedArgsJsonConverter extends JsonConverter<List<NamedArg>, List<dynamic>> {
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

class ExecutableDeployItemJsonConverter implements JsonConverter<ExecutableDeployItem, Map<String, dynamic>> {
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
    throw UnimplementedError();
  }
}
