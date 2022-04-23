import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/serde/byte_serializable.dart';
import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/cl_value.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClValue implements ByteSerializable {
  @JsonKey(name: 'cl_type')
  @ClTypeDescriptorJsonConverter()
  ClTypeDescriptor clTypeDescriptor;

  @HexBytesWithCep57ChecksumConverter()
  Uint8List bytes;

  dynamic parsed;

  factory ClValue.fromJson(Map<String, dynamic> json) => _$ClValueFromJson(json);
  Map<String, dynamic> toJson() => _$ClValueToJson(this);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter();
    mem.writeInt32(bytes.length);
    mem.write(bytes);
    mem.write(clTypeDescriptor.toBytes());
    return mem.toBytes();
  }

  ClValue(this.clTypeDescriptor, this.bytes);
}
