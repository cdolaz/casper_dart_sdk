import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cl_value.g.dart';

@JsonSerializable()
class ClValue {
  @JsonKey(name: 'cl_type')
  @ClTypeJsonConverter()
  ClType clType;

  @JsonKey(name: 'bytes')
  @HexBytesWithCep57ChecksumConverter()
  List<int> bytes;

  @JsonKey(name: 'parsed')
  String? parsed;

  Uint8List get bytesAsUint8List => Uint8List.fromList(bytes);

  factory ClValue.fromJson(Map<String, dynamic> json) =>
      _$ClValueFromJson(json);

  Map<String, dynamic> toJson() => _$ClValueToJson(this);

  ClValue(this.clType, this.bytes);
}

class HexBytesWithCep57ChecksumConverter
    implements JsonConverter<List<int>, String> {
  const HexBytesWithCep57ChecksumConverter();

  @override
  List<int> fromJson(String json) {
    return Cep57Checksum.decode(json).item2.toList();
  }

  @override
  String toJson(List<int> object) {
    return Cep57Checksum.encode(Uint8List.fromList(object));
  }
}
