import 'dart:convert';
import 'dart:typed_data';

import 'package:casper_dart_sdk/src/types/cl_value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/serde/byte_serializable.dart';
import 'package:buffer/buffer.dart';

part 'generated/named_arg.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NamedArg implements ByteSerializable {
  String name;

  ClValue value;

  factory NamedArg.fromJson(Map<String, dynamic> json) => _$NamedArgFromJson(json);
  Map<String, dynamic> toJson() => _$NamedArgToJson(this);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    List<int> nameBytes = utf8.encode(name);
    mem.writeInt32(nameBytes.length);
    mem.write(nameBytes);
    mem.write(value.toBytes());
    return mem.toBytes();
  }

  NamedArg(this.name, this.value);
}
