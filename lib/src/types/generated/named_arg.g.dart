// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../named_arg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedArg _$NamedArgFromJson(Map<String, dynamic> json) => NamedArg(
      json['name'] as String,
      ClValue.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NamedArgToJson(NamedArg instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };
