// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../cl_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClValue _$ClValueFromJson(Map<String, dynamic> json) => ClValue(
      const ClTypeDescriptorJsonConverter().fromJson(json['cl_type']),
      const HexBytesWithCep57ChecksumConverter()
          .fromJson(json['bytes'] as String),
    )..parsed = json['parsed'];

Map<String, dynamic> _$ClValueToJson(ClValue instance) => <String, dynamic>{
      'cl_type': const ClTypeDescriptorJsonConverter()
          .toJson(instance.clTypeDescriptor),
      'bytes':
          const HexBytesWithCep57ChecksumConverter().toJson(instance.bytes),
      'parsed': instance.parsed,
    };
