// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../executable_deploy_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleBytesDeployItem _$ModuleBytesDeployItemFromJson(
        Map<String, dynamic> json) =>
    ModuleBytesDeployItem(
      const NamedArgsJsonConverter().fromJson(json['args'] as List),
      const NullableHexStringBytesJsonConverter()
          .fromJson(json['module_bytes'] as String?),
    );

Map<String, dynamic> _$ModuleBytesDeployItemToJson(
        ModuleBytesDeployItem instance) =>
    <String, dynamic>{
      'args': const NamedArgsJsonConverter().toJson(instance.args),
      'module_bytes': const NullableHexStringBytesJsonConverter()
          .toJson(instance.moduleBytes),
    };

StoredContractByHashDeployItem _$StoredContractByHashDeployItemFromJson(
        Map<String, dynamic> json) =>
    StoredContractByHashDeployItem(
      json['hash'] as String,
      json['entry_point'] as String,
      const NamedArgsJsonConverter().fromJson(json['args'] as List),
    );

Map<String, dynamic> _$StoredContractByHashDeployItemToJson(
        StoredContractByHashDeployItem instance) =>
    <String, dynamic>{
      'args': const NamedArgsJsonConverter().toJson(instance.args),
      'hash': instance.hash,
      'entry_point': instance.entryPoint,
    };

StoredContractByNameDeployItem _$StoredContractByNameDeployItemFromJson(
        Map<String, dynamic> json) =>
    StoredContractByNameDeployItem(
      json['name'] as String,
      json['entry_point'] as String,
      const NamedArgsJsonConverter().fromJson(json['args'] as List),
    );

Map<String, dynamic> _$StoredContractByNameDeployItemToJson(
        StoredContractByNameDeployItem instance) =>
    <String, dynamic>{
      'args': const NamedArgsJsonConverter().toJson(instance.args),
      'name': instance.name,
      'entry_point': instance.entryPoint,
    };

StoredVersionedContractByHashDeployItem
    _$StoredVersionedContractByHashDeployItemFromJson(
            Map<String, dynamic> json) =>
        StoredVersionedContractByHashDeployItem(
          json['hash'] as String,
          json['version'] as int?,
          json['entry_point'] as String,
          const NamedArgsJsonConverter().fromJson(json['args'] as List),
        );

Map<String, dynamic> _$StoredVersionedContractByHashDeployItemToJson(
        StoredVersionedContractByHashDeployItem instance) =>
    <String, dynamic>{
      'args': const NamedArgsJsonConverter().toJson(instance.args),
      'hash': instance.hash,
      'version': instance.version,
      'entry_point': instance.entryPoint,
    };

StoredVersionedContractByNameDeployItem
    _$StoredVersionedContractByNameDeployItemFromJson(
            Map<String, dynamic> json) =>
        StoredVersionedContractByNameDeployItem(
          json['name'] as String,
          json['version'] as int?,
          json['entry_point'] as String,
          const NamedArgsJsonConverter().fromJson(json['args'] as List),
        );

Map<String, dynamic> _$StoredVersionedContractByNameDeployItemToJson(
        StoredVersionedContractByNameDeployItem instance) =>
    <String, dynamic>{
      'args': const NamedArgsJsonConverter().toJson(instance.args),
      'name': instance.name,
      'version': instance.version,
      'entry_point': instance.entryPoint,
    };

TransferDeployItem _$TransferDeployItemFromJson(Map<String, dynamic> json) =>
    TransferDeployItem(
      const NamedArgsJsonConverter().fromJson(json['args'] as List),
    );

Map<String, dynamic> _$TransferDeployItemToJson(TransferDeployItem instance) =>
    <String, dynamic>{
      'args': const NamedArgsJsonConverter().toJson(instance.args),
    };
