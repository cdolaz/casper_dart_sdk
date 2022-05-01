import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/helpers/byte_utils.dart';
import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/serde/byte_serializable.dart';
import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/cl_value.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClValue implements ByteSerializable {
  @JsonKey(name: 'cl_type')
  @ClTypeDescriptorJsonConverter()
  late ClTypeDescriptor clTypeDescriptor;

  @HexBytesWithCep57ChecksumConverter()
  late Uint8List bytes;

  late dynamic parsed;

  factory ClValue.fromJson(Map<String, dynamic> json) => _$ClValueFromJson(json);
  Map<String, dynamic> toJson() => _$ClValueToJson(this);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt32(bytes.length);
    mem.write(bytes);
    mem.write(clTypeDescriptor.toBytes());
    return mem.toBytes();
  }

  ClValue(this.clTypeDescriptor, this.bytes, this.parsed);

  ClValue.bool(bool value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.bool);
    bytes = value ? Uint8List.fromList([0x01]) : Uint8List.fromList([0x00]);
    parsed = value;
  }

  ClValue.i32(int value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.i32);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt32(value);
    bytes = mem.toBytes();
    parsed = value;
  }

  ClValue.i64(int value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.i64);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt64(value);
    bytes = mem.toBytes();
    parsed = value;
  }

  ClValue.u8(int value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.u8);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(value);
    bytes = mem.toBytes();
    parsed = value;
  }

  ClValue.u32(int value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.u32);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint32(value);
    bytes = mem.toBytes();
    parsed = value;
  }

  ClValue.u64(int value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.u64);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint64(value);
    bytes = mem.toBytes();
    parsed = value;
  }

  ClValue.u128(BigInt value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.u128);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    // Warning: ByteDataWriter.write() does not change the ordering
    // of the bytes regardless of the endianness of the writer.
    // So, we need to reverse the bytes.
    Uint8List bytes = encodeUnsignedBigIntAsLittleEndian(value);
    mem.writeUint8(bytes.length);
    mem.write(bytes);
    this.bytes = mem.toBytes();
    parsed = value.toString();
  }

  ClValue.u256(BigInt value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.u256);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    // Warning: ByteDataWriter.write() does not change the ordering
    // of the bytes regardless of the endianness of the writer.
    // So, we need to reverse the bytes.
    Uint8List bytes = encodeUnsignedBigIntAsLittleEndian(value);
    mem.writeUint8(bytes.length);
    mem.write(bytes);
    this.bytes = mem.toBytes();
    parsed = value.toString();
  }

  ClValue.u512(BigInt value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.u512);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    // Warning: ByteDataWriter.write() does not change the ordering
    // of the bytes regardless of the endianness of the writer.
    // So, we need to reverse the bytes.
    Uint8List bytes = encodeUnsignedBigIntAsLittleEndian(value);
    mem.writeUint8(bytes.length);
    mem.write(bytes);
    this.bytes = mem.toBytes();
    parsed = value.toString();
  }

  ClValue.unit() {
    clTypeDescriptor = ClTypeDescriptor(ClType.unit);
    bytes = Uint8List.fromList([]);
    parsed = null;
  }

  ClValue.string(String value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.string);
    Uint8List stringBytes = Uint8List.fromList(utf8.encode(value));
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt32(stringBytes.length);
    mem.write(stringBytes);
    bytes = mem.toBytes();
    parsed = value;
  }

  ClValue.uref(Uref value) {
    clTypeDescriptor = ClTypeDescriptor(ClType.uref);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(value.headlessBytes);
    mem.writeUint8(value.accessRights.index);
    bytes = mem.toBytes();
    parsed = value.key;
  }

  ClValue.option(ClValue inner) {
    clTypeDescriptor = ClOptionTypeDescriptor(inner.clTypeDescriptor);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(0x01);
    mem.write(inner.bytes);
    bytes = mem.toBytes();
    parsed = inner.parsed;
  }

  ClValue.optionNone(ClTypeDescriptor innerType) {
    clTypeDescriptor = ClOptionTypeDescriptor(innerType);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(0x00);
    bytes = mem.toBytes();
    parsed = null;
  }

  ClValue.list(List<ClValue> values) {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    if (values.isEmpty) {
      throw ArgumentError('List cannot be empty');
    }
    final innerTypeDesc = values.first.clTypeDescriptor;
    clTypeDescriptor = ClListTypeDescriptor(innerTypeDesc);
    mem.writeInt32(values.length);
    for (ClValue value in values) {
      if (innerTypeDesc == value.clTypeDescriptor) {
        mem.write(value.bytes);
      } else {
        throw ArgumentError('All elements of list must have the same type');
      }
    }
    bytes = mem.toBytes();
    parsed = "";
  }

  ClValue.emptyList(ClTypeDescriptor listType) {
    clTypeDescriptor = ClListTypeDescriptor(listType);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt32(0);
    bytes = mem.toBytes();
    parsed = "";
  }

  ClValue.byteArray(Uint8List byteArray) {
    clTypeDescriptor = ClByteArrayTypeDescriptor(byteArray.length);
    bytes = byteArray;
    parsed = hex.encode(byteArray);
  }

  ClValue.byteArrayFromHex(String hexStr) {
    bytes = Uint8List.fromList(hex.decode(hexStr));
    clTypeDescriptor = ClByteArrayTypeDescriptor(bytes.length);
    parsed = hex;
  }

  ClValue.key(GlobalStateKey key) {
    bytes = key.toBytes();
    clTypeDescriptor = ClTypeDescriptor(ClType.key);
    parsed = {key.keyIdentifier.identifierName: key.key};
  }

  ClValue.publicKey(ClPublicKey key) {
    bytes = key.bytesWithKeyAlgorithmIdentifier;
    clTypeDescriptor = ClTypeDescriptor(ClType.publicKey);
    parsed = hex.encode(key.bytesWithKeyAlgorithmIdentifier);
  }

  ClValue.map(Map<ClValue, ClValue> map) {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeInt32(map.length);
    ClMapTypeDescriptor? mapTypeDesc;
    for (ClValue key in map.keys) {
      if (mapTypeDesc == null) {
        mapTypeDesc = ClMapTypeDescriptor(key.clTypeDescriptor, map.values.first.clTypeDescriptor);
      } else if (mapTypeDesc.keyType != key.clTypeDescriptor) {
        throw ArgumentError('All keys of map must have the same type');
      } else if (mapTypeDesc.valueType != map.values.first.clTypeDescriptor) {
        throw ArgumentError('All values of map must have the same type');
      }
      mem.write(key.bytes);
      mem.write(map[key]!.bytes);
    }
    bytes = mem.toBytes();
    clTypeDescriptor = mapTypeDesc!;
    parsed = null;
  }

  ClValue.ok(ClValue value, ClTypeDescriptor errorType) {
    clTypeDescriptor = ClResultTypeDescriptor(value.clTypeDescriptor, errorType);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(0x01);
    mem.write(value.bytes);
    bytes = mem.toBytes();
    parsed = null;
  }

  ClValue.error(ClValue value, ClTypeDescriptor okType) {
    clTypeDescriptor = ClResultTypeDescriptor(okType, value.clTypeDescriptor);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(0x00);
    mem.write(value.bytes);
    bytes = mem.toBytes();
    parsed = null;
  }

  ClValue.tuple1(ClValue value) {
    clTypeDescriptor = ClTuple1TypeDescriptor(value.clTypeDescriptor);
    bytes = value.bytes;
    parsed = value.parsed;
  }

  ClValue.tuple2(ClValue value1, ClValue value2) {
    clTypeDescriptor = ClTuple2TypeDescriptor(value1.clTypeDescriptor, value2.clTypeDescriptor);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(value1.bytes);
    mem.write(value2.bytes);
    bytes = mem.toBytes();
    parsed = hex.encode(bytes);
  }

  ClValue.tuple3(ClValue value1, ClValue value2, ClValue value3) {
    clTypeDescriptor = ClTuple3TypeDescriptor(value1.clTypeDescriptor, value2.clTypeDescriptor, value3.clTypeDescriptor);
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(value1.bytes);
    mem.write(value2.bytes);
    mem.write(value3.bytes);
    bytes = mem.toBytes();
    parsed = hex.encode(bytes);
  }
}
