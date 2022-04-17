// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../named_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedKey _$NamedKeyFromJson(Map<String, dynamic> json) => NamedKey(
      json['name'] as String,
      const GlobalStateKeyJsonConverter().fromJson(json['key'] as String),
    );

Map<String, dynamic> _$NamedKeyToJson(NamedKey instance) => <String, dynamic>{
      'name': instance.name,
      'key': const GlobalStateKeyJsonConverter().toJson(instance.key),
    };
